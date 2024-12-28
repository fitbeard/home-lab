packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}

variable "disk_size" {
  type    = string
  default = "30G"
}

variable "iso_checksum" {
  type    = string
  default = "628c069c9685477360640a6b58dc919692a11c44b49a50a024b5627ce3c27d5f"
}

variable "iso_url" {
  type    = string
  default = "https://rocky.task.gda.pl/9.5/isos/x86_64/Rocky-9.5-x86_64-boot.iso"
}

variable "packer_virt_sysprep_dir" {
  type    = string
  default = "/packer-virt-sysprep"
}

variable "ssh_password" {
  type    = string
  default = "password"
}

variable "sysprep_op_bash_history" {
  type    = string
  default = "true"
}

variable "sysprep_op_crash_data" {
  type    = string
  default = "true"
}

variable "sysprep_op_logfiles" {
  type    = string
  default = "true"
}

variable "sysprep_op_machine_id" {
  type    = string
  default = "true"
}

variable "sysprep_op_mail_spool" {
  type    = string
  default = "true"
}

variable "sysprep_op_package_manager_cache" {
  type    = string
  default = "true"
}

variable "sysprep_op_rpm_db" {
  type    = string
  default = "true"
}

variable "sysprep_op_ssh_hostkeys" {
  type    = string
  default = "true"
}

variable "sysprep_op_tmp_files" {
  type    = string
  default = "true"
}

variable "sysprep_op_yum_uuid" {
  type    = string
  default = "true"
}

variable "vm_name" {
  type    = string
  default = "rocky9-packer"
}

source "qemu" "rocky9" {
  accelerator        = "kvm"
  boot_command       = ["<up><wait><tab><wait> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
  boot_wait          = "5s"
  cpus               = "2"
  disk_cache         = "none"
  disk_compression   = "true"
  disk_detect_zeroes = "on"
  disk_discard       = "unmap"
  disk_interface     = "virtio"
  disk_size          = "${var.disk_size}"
  display            = "none"
  format             = "qcow2"
  headless           = true
  http_directory     = "http"
  iso_checksum       = "${var.iso_checksum}"
  iso_url            = "${var.iso_url}"
  memory             = "2048"
  net_bridge         = "br.mgmt"
  net_device         = "virtio-net"
  output_directory   = "output"
  qemu_binary        = "/usr/libexec/qemu-kvm"
  cpu_model          = "host"
  machine_type       = "q35"
  # shutdown_command   = "/sbin/shutdown -hP now" # On QEMU 8.2 and Packer 1.11.2 Rocky Linux 9 shutdown step freezes. Doing force shutdown here.
  skip_compaction    = "false"
  ssh_password       = "${var.ssh_password}"
  ssh_timeout        = "20m"
  ssh_pty            = "true"
  ssh_username       = "root"
  vm_name            = "${var.vm_name}.qcow2"
  vnc_bind_address   = "0.0.0.0"
  vnc_port_max       = "6000"
  vnc_port_min       = "5900"
  vnc_use_password   = "false"
}

build {
  sources = ["source.qemu.rocky9"]

  provisioner "shell" {
    environment_vars = ["PACKER_VIRT_SYSPREP_DIR=${var.packer_virt_sysprep_dir}"]
    execute_command  = "{{ .Vars }} $(command -v bash) '{{ .Path }}'"
    inline           = ["mkdir $PACKER_VIRT_SYSPREP_DIR"]
  }

  provisioner "file" {
    destination = "${var.packer_virt_sysprep_dir}"
    source      = "scripts/packer-virt-sysprep/"
  }

  provisioner "shell" {
    environment_vars = ["PACKER_VIRT_SYSPREP_DIR=${var.packer_virt_sysprep_dir}", "SYSPREP_OP_BASH_HISTORY=${var.sysprep_op_bash_history}", "SYSPREP_OP_CRASH_DATA=${var.sysprep_op_crash_data}", "SYSPREP_OP_LOGFILES=${var.sysprep_op_logfiles}", "SYSPREP_OP_MACHINE_ID=${var.sysprep_op_machine_id}", "SYSPREP_OP_MAIL_SPOOL=${var.sysprep_op_mail_spool}", "SYSPREP_OP_PACKAGE_MANAGER_CACHE=${var.sysprep_op_package_manager_cache}", "SYSPREP_OP_RPM_DB=${var.sysprep_op_rpm_db}", "SYSPREP_OP_SSH_HOSTKEYS=${var.sysprep_op_ssh_hostkeys}", "SYSPREP_OP_TMP_FILES=${var.sysprep_op_tmp_files}", "SYSPREP_OP_YUM_UUID=${var.sysprep_op_yum_uuid}"]
    execute_command  = "{{ .Vars }} $(command -v bash) '{{ .Path }}'"
    remote_folder    = "${var.packer_virt_sysprep_dir}"
    script           = "scripts/packer-virt-sysprep.sh"
  }

  provisioner "shell" {
    environment_vars = ["PACKER_VIRT_SYSPREP_DIR=${var.packer_virt_sysprep_dir}"]
    execute_command  = "{{ .Vars }} $(command -v bash) '{{ .Path }}'"
    inline           = ["rm -rf $PACKER_VIRT_SYSPREP_DIR"]
  }

  provisioner "shell" {
    execute_command = "$(command -v bash) '{{ .Path }}'"
    scripts         = ["scripts/dd-cleanup.sh"]
  }

}
