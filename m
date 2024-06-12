Return-Path: <linux-spi+bounces-3390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A809905963
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCE4284EB9
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812A208D6;
	Wed, 12 Jun 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9fnDNKX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C2183080;
	Wed, 12 Jun 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211638; cv=none; b=M2KmREiVCI3ekLZ/5Qv4phX1nEYK+smTsl2TaYLJkGMvhOYUJsf8DwVvbTjWce6ptMFmccDKTzDYdnlyT9AmN9W5PsoOfhpLokhlca6L7mJ9qb6IAnMKJ0QCSyN7fliOhTGC8Q7P8B7vjbtH21ZGjpe6oNPLbsXweevhwobWffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211638; c=relaxed/simple;
	bh=lqE79zu8rzhor3lW5UBluOhxhcwYKIk9FUShPE40gYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KdYXUCySs2NkMUbctytCGZaZGxe4aNygpbSgXyIg3ddfdeXH9v9Mk+8UOpfdFhczA2oRngLrTfu1P+bfmQG4r/Tlp0ju8nSyCj+fwzwWQXnnDDW4UMO+8mdZyLy/Zmtb+RDep5AymPG9ppCo7nSfCcY+vA2V1ZOULP2TDRogcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9fnDNKX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so31400a12.3;
        Wed, 12 Jun 2024 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718211636; x=1718816436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8SoxPtYA/ySvPLjX9PzTkrLHwkpIWGqoZYbRDl1Eng=;
        b=a9fnDNKXFKpol27ExI9ZrYJc8ZA7UvOePwDP6+l5oS+J0dqfcsQDEIakHXRW7nT3Y/
         Vsknxb+SN54SDt9LSc4DCqhC4QB7xGYektghht3xBxH8yr+2peBCiiUj7bPHhcwU1Bkj
         50js5XgvzYey0WCOqNKSQVpUM0kTWs6BL1cXOedcenahROyMkkXO7FyImm2rjRVI9KWv
         OPir+W2rWgmlIM0cTxPPj8NUDpBf778xi3me99NczKSJ/1gsP6zXPliIXegpMzveE+nP
         ZHNheOb/QrkvywWT640m90XZvc+rsSL+Py1HQ/U9FYTRXIUMs4aQVtTzsY31Z9nlwHUF
         KSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211636; x=1718816436;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8SoxPtYA/ySvPLjX9PzTkrLHwkpIWGqoZYbRDl1Eng=;
        b=CNhGMsTBQZ/G/EnTf57y9AmIJZVY3mGlCcp7+C/a6fhff6kssa4Rm/4vJc/KbMK5Qg
         hWE2Eiu+16daaGQptWZLxWiUvTT8CNYI+6S/E8qYGUhJS85FDn8l/wZJo972HPJvdftq
         B4yRHhJ+w32fxA/OcIQKi0jo1BHJfpA5V+Z6DMBIV6vxIQnJ4B3942YjyOVFdKa505/r
         QP3JjtmEZN3RLor8Eu4Hiolg1+e0FvrUzDZKnJvtDrONw5AdROXip14zIeDG0vCHwkzi
         lIdogGUKp5id3nHlvOQQkph3YwNoDVeXyn4JvIFbGPJparxlBV9e3yznjPWJ3WyfTnZH
         87sQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41VH2h3lckOp0sKASi9uvYHR0mlJcNPrtIRc/p7jQFjLD9ZWGhElvx1oCK3nRvlyGr4Zg/2NqMICfDlAI6uQsF9oADK5vv7lNCIiX
X-Gm-Message-State: AOJu0YwWkHkq1UEVlXpjyNivKPh2LNffY/6DUZrvofO75pOFd3qSP2fE
	T0ld4ORIHEtjBFh5h+TcdVTFD0lBy0AylBFrW8nij/7kW+TEnNGZ
X-Google-Smtp-Source: AGHT+IGosqfeCDaaocC1WpO+ZAWk0NosMCmvHTRagVZcRjDLWB32wjayW9BHquxBUtLVsK0GCUWaDw==
X-Received: by 2002:a17:902:d50b:b0:1f7:38a2:f1ec with SMTP id d9443c01a7336-1f83b67a940mr30772695ad.36.1718211635494;
        Wed, 12 Jun 2024 10:00:35 -0700 (PDT)
Received: from joaog-nb (201-13-139-53.dial-up.telesp.net.br. [201.13.139.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7065dff1csm70778135ad.213.2024.06.12.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:00:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:00:30 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Mark Brown <broonie@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	joao.goncalves@toradex.com
Subject: [REGRESSION] spi: omap2-mcspi: not working with kernel v6.10
Message-ID: <20240612170030.3qatttsgrwjg2m5s@joaog-nb>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

It appears that omap2-mcspi broke on kernel v6.10. I was testing an EEPROM like
SPI FRAM using this DT:

&main_spi1 {
	pinctrl-0 = <&pinctrl_spi1>,
		    <&pinctrl_gpio_4>;
	cs-gpios =  <&mcu_gpio0 4 GPIO_ACTIVE_LOW>;
	status = "okay";

	fram@0 {
		compatible = "fujitsu,mb85rs256", "atmel,at25";
		reg = <0>;
		address-width = <16>;
		size = <32768>;
		spi-max-frequency = <33000000>;
		pagesize = <1>;
	};
};

On kernel v6.9, spi works fine and is possible to read/write the FRAM. However,
on kernel v6.10-rc3 it gives me an Oops after a timeout:

[  201.966498] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
[  201.972764] Modules linked in: cfg80211 bluetooth ecdh_generic ecc rfkill
usb_f_ncm u_ether crct10dif_ce powervr drm_gpuvm drm_exec drm_shmem_helper
mux_gpio gpu_sched rtc_ti_k3 k3_j72xx_bandgap rti_wdt tps65219_pwrbutton
ti_ads1015 m_can_platform rtc_ds1307 industrialio_triggered_buffer sa2ul
m_can kfifo_buf lm75 authenc can_dev at24 spi_omap2_mcspi omap_mailbox
libcomposite fuse drm backlight ipv6
[  202.008216] CPU: 1 PID: 462 Comm: hexdump Not tainted 6.10.0-rc3-00002-g05e382bde33c #1
[  202.016213] Hardware name: Toradex Verdin AM62 on Ivy Board (DT)
[  202.022212] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  202.029167] pc : omap2_mcspi_transfer_one+0x7d8/0xb78 [spi_omap2_mcspi]
[  202.035790] lr : omap2_mcspi_transfer_one+0x7d4/0xb78 [spi_omap2_mcspi]
[  202.042397] sp : ffff80008384b7d0
[  202.045703] x29: ffff80008384b7d0 x28: ffff0000036b0c00 x27: ffff80008328313c
[  202.052838] x26: ffff00000461cd80 x25: ffff000004625640 x24: ffff00001db00000
[  202.059971] x23: ffff800083283130 x22: 0000000000000000 x21: 00000000e5c8ed77
[  202.067103] x20: ffff80008384bb88 x19: 0000000000000000 x18: 0000000000000000
[  202.074235] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  202.081367] x14: 00000000000000e6 x13: 0000000000000000 x12: 0000000000000001
[  202.088499] x11: ffff0000046256c0 x10: 0000000000000aa0 x9 : 0000000020000000
[  202.095632] x8 : 0000000000000000 x7 : 0000000020161bc4 x6 : ffff00000421e780
[  202.102765] x5 : 0000000000000000 x4 : ffff8000825e7000 x3 : 00000000ffffa0ff
[  202.109897] x2 : 0000000000000002 x1 : 0000000000000002 x0 : 0000000000000000
[  202.117030] Call trace:
[  202.119471]  omap2_mcspi_transfer_one+0x7d8/0xb78 [spi_omap2_mcspi]
[  202.125734]  spi_transfer_one_message+0x2fc/0x648
[  202.130442]  __spi_pump_transfer_message+0x234/0x4e8
[  202.135401]  __spi_sync+0x2a8/0x3c0
[  202.138885]  spi_sync+0x30/0x54
[  202.142022]  at25_ee_read+0x160/0x230
[  202.145682]  nvmem_reg_read+0x24/0x4c
[  202.149346]  bin_attr_nvmem_read+0x84/0xb4
[  202.153439]  sysfs_kf_bin_read+0x6c/0x8c
[  202.157364]  kernfs_fop_read_iter+0xa0/0x1b4
[  202.161630]  vfs_read+0x24c/0x2f4
[  202.164944]  ksys_read+0x6c/0xf8
[  202.168168]  __arm64_sys_read+0x1c/0x28
[  202.172000]  invoke_syscall+0x44/0x108
[  202.175749]  el0_svc_common.constprop.0+0xc0/0xe0
[  202.180450]  do_el0_svc+0x1c/0x28
[  202.183761]  el0_svc+0x34/0xdc
[  202.186815]  el0t_64_sync_handler+0xc0/0xc4
[  202.190994]  el0t_64_sync+0x190/0x194
[  202.194658] Code: aa1703e0 d2800041 97fffb9f 37f80e40 (b8404700)
[  202.200746] ---[ end trace 0000000000000000 ]---

Regards,
João Paulo Gonçalves

