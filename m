Return-Path: <linux-spi+bounces-8065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6E2AB2881
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08346172A1D
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B11257434;
	Sun, 11 May 2025 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDd8uIqP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85D2571CD;
	Sun, 11 May 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970298; cv=none; b=Q//HYH0yjNojEfrwuuL+A9Djp5f6ckQi6ypzVVwJ8d1GPH5DmqDQO2FOYbK3oSHzkDjk57trXw0tPVhzBmtrYT1DWE8JNpf6swnr5W5F3VXCthxkQpSKxpntQI/rwTWikpXJSk6CAqlCAW4WxJCBh15b/RFnoDWOTUfG/n+cU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970298; c=relaxed/simple;
	bh=v7V7RZABxDpzTCd01jnnzt/qeDr0mJMKGJhF94ABrK8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrK1BhuMHHN5+P2+F8nxLTAB0UveFfbEqF3uV3zpFotgDcMPVGN0Vq/0f5lQNtUuyGp8ecdMiYKJnq73SRqkKwMQoQY3f8XaPha+2c4IvCX3tSZmiTn5i4XcjPW38/woiZq5oIHI1Rt5KrI5ZOoizrsvXdGSC3PCJchUQpDJD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDd8uIqP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso3313995a91.3;
        Sun, 11 May 2025 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746970296; x=1747575096; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/e+QlwuOBaTQegQySoATY3jFu5uRVYu74q7ghqDm3w=;
        b=XDd8uIqPkA85B2vSFj8L2dus0+oV+a0MOg6AEDkpt2oCCk0pKA4cJQQBQaaYkPS2Ic
         bvEiOPqzEKINPqW+V/nts7MTPcUZI1R50TwGlCAb13EL4b+UtMBzARgttbsdvxEM90Jf
         1b/TOymGWbbszhnIzqmSgVFDHd8z3YtsETlZDzs/KpMcyiUc+YFJ9SxQoRaZus0NQSsZ
         j+gTpSV5fh8bYQhOAVRxXPVHU0KC0934C2BG/YeJ7Zhhc2iVkTUMDPQOOfHJh6Ie466/
         EQCS6oJ1aj5J90/rqXzaHJmfxhfy1TYZFQPQeTmLr2XAt8DBzYIBZ8z174ZwppCejgmr
         P2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746970296; x=1747575096;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/e+QlwuOBaTQegQySoATY3jFu5uRVYu74q7ghqDm3w=;
        b=fW6fjxAA1Sg5yNyojnr88CwVRFpOaTQlKCh8a/HUe8vVHsyBmzAsqQDTt1lQZh0Bkf
         O84xIYqS5XG7vBtCe7OheCeyFza1p4r4htvUk4BpEM64epwH/5B8cqxMu9f6xD8usW0C
         WRRBOQutuvU/Bl2D88JJlfREDvHVF7IgQ+pOcO2ax2SXJvlKe37xOiyXRQEqdMCFarYY
         0jpqm4hZaCvBI4P5o1dsgP8aTXtQL/JNUNlq8/VyZqvkJx5zVwzs6yjVqoOQGAYZentT
         Ymj4jYX2V499cV3Qo+ts98pl8PiH93ADczBqZtWN5YTSIj+bpY3622dsDxwUeqaYk9YI
         w3EA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHBQouW4UiEvop7ML4yzucYazipC+3OHsWrqY3LtTGn8H7XpV0cwlleizH5TKqba4Wclai3q2@vger.kernel.org, AJvYcCW7ql6ZKpsazlB321zauZ5ROYknSyyMug2qr6+XiQvCE1f2svalC5DculqH3LILevVXGiSzn8zdZG2P@vger.kernel.org, AJvYcCXVMGk0QR5QAGONblszCSezJcPZGOqukO4sM/BQNj3l/K8INVf6AS4Q8HWCSppnA0+1eJlHvW72Knar1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfB0JATXHhNIxX/cQxbwNRa23hjalnxDrwjMgyvLdmAqRQzoV
	JDNkzdIoU41JH6LXRxdcuXIOhD/O856hO0jC9A+9UyYT6D7bR4PM
X-Gm-Gg: ASbGnct6U/2OGrtLL1A3oCwxnQ3V1MN6Yd52G+QwbGLDzJsilblVNNAz7e86pJTCFBd
	1HaEsRLYIq9pUx3cRHR0zmfzt8Bs78O0IggkvPxbmEbSnEEfuW8xM2qYKZKiwr4FVmr14Xo80V6
	oKbVUmBZJ+jIXw7JyqeEJudKw0FryEOy4oJSH+Sm56cpqS1qRsUKsHueZdmC1t6BIo2cleiGeKk
	v2k+IyeLFbuPwdIRv3NQisBVIVjPaU15LkU1T68QbUwERcJiRx6lC9TNIzsCi3z+qcE4HnUbDmn
	Z/4xvuz8LVrI+76ti05/3BlA7HpU6CD1bup2FMo6GAh8y9efc9SZxJ5ISXv1MJMZOyjbq+zfN22
	/3C1NPg==
X-Google-Smtp-Source: AGHT+IGPLu/UA8RferE1fhhUBg8P8fBAwEHMaR6Zwjv2pyeF/9jF35bRMmgJBhPOKiliyYy+r0TG1A==
X-Received: by 2002:a17:90b:2ecb:b0:2fe:ac91:4667 with SMTP id 98e67ed59e1d1-30c3d65e82cmr15029864a91.29.1746970296420;
        Sun, 11 May 2025 06:31:36 -0700 (PDT)
Received: from localhost (58x12x133x161.ap58.ftth.ucom.ne.jp. [58.12.133.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e61056sm4834312a91.39.2025.05.11.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 06:31:35 -0700 (PDT)
Date: Sun, 11 May 2025 22:31:29 +0900
Message-ID: <eke7wmanw9xq.wl-kobarity@gmail.com>
From: kobarity <kobarity@gmail.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Berkel =?ISO-8859-1?Q?J=F6rg?= <joerg.berkel@bfh.ch>,	Robin Murphy
 <robin.murphy@arm.com>,	Baolu Lu <baolu.lu@linux.intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,	"lukas@wunner.de"
 <lukas@wunner.de>,	David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,	Joerg Roedel
 <joro@8bytes.org>,	Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
In-Reply-To: <PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
	<PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
	<f1b41874-1535-4457-9747-eee3d816091a@arm.com>
	<PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
	<PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/31.0.50 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: multipart/mixed;
 boundary="Multipart_Sun_May_11_22:31:29_2025-1"

--Multipart_Sun_May_11_22:31:29_2025-1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi

I'm also experiencing this problem on my MacBookPro14,3.

Aditya Garg wrote:
>=20
> Hi J=F6rg
>=20
> Can you test the kernel here to see if this fixes your issue:
>=20
> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/14944=
200356
>=20
> Alternatively you can try compiling your own kernel with this patch:
>=20
> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@nvi=
dia.com/

As far as I have tried, this patch did not solve the problem.

By bisecting, I found that this problem was introduced by commit
2031c469f816 ("iommu/vt-d: Add support for static identity domain").
In fact, since this commit, it will panic at startup.  This panic was
fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
and touchpad is not working.

I also found that I can workaround this problem by reverting only the
intel_iommu_attach_device() change in commit 2031c469f816 as in the
attached patch, but I'm not sure if this is a reasonable fix.


--Multipart_Sun_May_11_22:31:29_2025-1
Content-Type: application/octet-stream; type=patch; name="workaround.patch"
Content-Disposition: attachment; filename="workaround.patch"
Content-Transfer-Encoding: 7bit

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb0b993bebb4..14da33490fa1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3484,9 +3484,11 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
-	device_block_translation(dev);
+	if (info->domain)
+		device_block_translation(dev);
 
 	ret = paging_domain_compatible(domain, dev);
 	if (ret)

--Multipart_Sun_May_11_22:31:29_2025-1--

