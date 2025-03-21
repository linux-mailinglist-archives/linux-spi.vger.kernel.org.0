Return-Path: <linux-spi+bounces-7268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80DA6BAF1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 13:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BB23BF693
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A912288F9;
	Fri, 21 Mar 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL7CSF6b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEF22A7EC;
	Fri, 21 Mar 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560879; cv=none; b=s19B6/EQNz5MsmuVjCzeD540POM+5qYZ/dmsGeSM+yXE7CFjOrvLmdSkV9Ks3Op8GATVgun1vRCUA3IrM3dj+N9wzd8xiztxW6uPV4ucxioiEZAw7XTfXhakWALIeOHdNkN/m2P/Gi5rpSkkkAepEkj4FPZtldshSesOilZvQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560879; c=relaxed/simple;
	bh=aQaT8NXm1uIZMmKfD8St00bQmPLI5VBD6kDXtl6YxNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sYlHsaVJPl2StDeFz2ZRFpK7ZhTe1g4sllIMuIzRtEkKQxgixJcCa4Jw4zR2ZGcsraOYaWKcOAbIjgt5AgDFqMXVFxf7qaddRe8l6nZB9xkL4k+GpTdTja+v5t90bMejLkykKFpfrYxpYFVhlJyNiv9CgMZilNGk72j8LoN1+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL7CSF6b; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301493f45aeso3172853a91.1;
        Fri, 21 Mar 2025 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560877; x=1743165677; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70ZDKQnVUrseidcoyIAmK71YjMWx4bwWDfQUhzn4pxE=;
        b=CL7CSF6bcVyc3LaDdi/UI8S5MnE92aGyz6juoH+Z3QH9YdwDJuG+GqlCbzjvCkKyb0
         nZDzA9ExCkTsX+FilT4+QpV7h9RTzNu2v2sA1louTTwJi0XE8c3jUkhVaLOoYv4NRuFU
         XHTAIvoN90Qm/NlwAvSVG/+CLJ+vQhZEkhDTECT3slV5yKQO+eqUl0AQBrnHV3xNcWx8
         zXkwkn2cdR8VS6QGeHlFF8Vq/bwiMOB2J1V6Bq26osk6lmvetN7gcLbcIFk04KPzE7Ar
         6bPJgJLpAsySFcH7bdW0k6Lz0ADdLAn2jzVraM32q3Eyq9JYELmH5pHDZJ0NQ6vwTSms
         2DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560877; x=1743165677;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70ZDKQnVUrseidcoyIAmK71YjMWx4bwWDfQUhzn4pxE=;
        b=q++YPprEbrmF9oZB2RMcsCbQDwdDN1cHcypqNbP09nwTEzlyMynSlwNuTPPh+xGuqv
         +MYCSHOhkXH0MzvQFydQKs7b0yCpZ7ir0xkRYLP02fcOZbyxPidvQEIebg4UosPzD9WU
         Poj+OYAlNnUR2agHbP1KUqeIKonygafFXPaJ8X6xOBdo868LUpK8OPVCYG+tXPx90jP4
         /9AYEiR2ymBI5MK5AnHg2d55aicypgQCsplmx7G2dJP9Of/OpfE5plWSfT4u0pQlwH0Z
         VQibdr3r/dShWrOcKfLFeMlH7b7Tomf51k5fpM1CkSAOAPQlZGAh/7ozlcB6Cvmmb3XU
         y6CA==
X-Forwarded-Encrypted: i=1; AJvYcCXxAL+Sy7ahURBucTYx8ryp6SOjap+YInfcBht/cm8XyacrAtufXkxmMFavTWVMbQg2jeZnx1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItPB9qhWzaqFuVLEtWEGzQWtZ6BUMPD6aGSm8KiJ/4HF6B7Y6
	/kTXcbce/UbRRSGPEbJvRuPERAHn0FFP5GB8ubX/oZWvY26VvezG
X-Gm-Gg: ASbGncvKjCCxxRKFDhu7C3ext+qa78hdRx9bfr8a2S43wjDIrMOXVuFEQi2zhO5LtXr
	+7y4Kk1QIKUhqDir/r0MsMZJmxrl8SPKOsktv1skZjF2VaJUWqeQvE8NFayY+VLpSmabtRX9h8U
	4tfVZhgizGsvJkc0/SVGxlAlTe8+3jl0po2ma+6xPXjY67VhbDLmmRDyZagAxYUpX5gwJt3KANa
	DWQdtH+79MXr63TARE6waIXedPAIh9TTEMT+DQqrPLStnkuZPxA83dA5P8rU99ikGGAKDOsx0E2
	z8aWhIabf82lWXEFEEh1s0b1QvckZ1toF38NGq+33oXCX/dw7IKAYtvLCPWuJ9+9jfU=
X-Google-Smtp-Source: AGHT+IG79LlBT4P7Hy6Lls22qhhJxan9Ekv7WrqEmwa/3D6K68Ks2MhOucNUweO4JqFnWK5dqbLd7g==
X-Received: by 2002:a17:90b:4fcc:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-3030fea7d0cmr5940896a91.16.1742560876577;
        Fri, 21 Mar 2025 05:41:16 -0700 (PDT)
Received: from localhost.localdomain ([147.11.105.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm6424975a91.40.2025.03.21.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:16 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 0/2] spi: fsl-qspi: Fix kernel panic when unbinding the SPI
 host
Date: Fri, 21 Mar 2025 20:40:20 +0800
Message-Id: <20250321-spi-v1-0-b9939baa64b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRe3WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3eKCTF2LFHNLS0tzM1NzM3MloMqCotS0zAqwKdGxtbUAfaaholU
 AAAA=
X-Change-ID: 20250321-spi-8d7999765767
To: linux-spi@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Volker Haspel <volker.haspel@linutronix.de>, 
 John Ogness <john.ogness@linutronix.de>, imx@lists.linux.dev, 
 Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Hi,

I observed a kernel panic on my imx8mq-evk board. It can be easily
reproduced with the following steps:
  while true; do cat /dev/mtd0 >/dev/null; done &
  echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind

The following is the kernel log:
  Unable to handle kernel paging request at virtual address ffffffc082a6015c
  Mem abort info:
    ESR = 0x0000000096000007
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x07: level 3 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000041dc3000
  [ffffffc082a6015c] pgd=1000000042779003, p4d=1000000042779003, pud=1000000042779003, pmd=1000000044631403, pte=0000000000000000
  Internal error: Oops: 0000000096000007 [#1]  SMP
  Modules linked in: 8021q ath10k_pci ath10k_core etnaviv snd_soc_fsl_asoc_card ath snd_soc_imx_audmux gpu_sched snd_soc_fsl_sai snd_soc_fsl_spdif imx_sdma imx_pcm_dma snd_soc_fsl_utils snd_soc_wm8524 sch_fq_codel openvswitch nsh nf_conncount nf_nat fuse configfs nfnetlink
  Hardware name: NXP i.MX8MQ EVK (DT)
  pc : fsl_qspi_exec_op+0xa8/0x7c0
  lr : fsl_qspi_exec_op+0x88/0x7c0
  sp : ffffffc08433b650
  x8 : ffffffc08433b748 x7 : 0000000000000000 x6 : 0000000000000004
  x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000004174
  x2 : 0032724c809254be x1 : 000000000000c2a2 x0 : 000000173a720be8
  Call trace:
   fsl_qspi_exec_op+0xa8/0x7c0 (P)
   spi_mem_exec_op+0x410/0x4a0
   spi_mem_no_dirmap_read+0xb0/0xd0
   spi_mem_dirmap_read+0xdc/0x150
   spi_nor_read_data+0x128/0x1a0
   spi_nor_read+0xf4/0x2c8
   mtd_read_oob_std+0x80/0x98
   mtd_read_oob+0x9c/0x168
   mtd_read+0x70/0xe0
   mtdchar_read+0x224/0x2a8
   vfs_read+0xcc/0x310
   ksys_read+0x78/0x118
   __arm64_sys_read+0x24/0x38
   invoke_syscall+0x5c/0x130
   el0_svc_common.constprop.0+0x48/0xf0
   do_el0_svc+0x24/0x38
   el0_svc+0x30/0xd0
   el0t_64_sync_handler+0x10c/0x138
   el0t_64_sync+0x198/0x1a0

CPU: 1 UID: 0 PID: 527 Comm: cat Not tainted 6.14.0-rc7-next-20250321-yocto-standard+ #11 PREEMPT
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
x29: ffffffc08433b670 x28: 0000007f8019f000 x27: 000000000000000e
x26: ffffff8004781140 x25: 000000173a814e28 x24: 0000000000000006
x23: ffffffc082a6015c x22: ffffff80046a3d80 x21: ffffff80046a3d98
x20: ffffffc082a60000 x19: ffffffc08433b9b8 x18: 0000000000000000
x17: 0000000000000000 x16: 003135312e373631 x15: 2e3432322e383231
x14: 0000000000000000 x13: ffffff80bf74d940 x12: 0000000000000000
x11: 0000000000000160 x10: 00000000000009b0 x9 : ffffffc08010ea78
Code: d2800141 d2800060 941ecb48 d503203f (b94002e1)
---
Kevin Hao (2):
      spi: fsl-qsi: Optimize fsl_qspi struct
      spi: fsl-qspi: Explicitly unregister SPI host in remove()

 drivers/spi/spi-fsl-qspi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250321-spi-8d7999765767

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


