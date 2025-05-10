Return-Path: <linux-spi+bounces-8056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C02AB2522
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 21:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E36E7B0673
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035B2367B7;
	Sat, 10 May 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZOxXfPP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C119B3CB;
	Sat, 10 May 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746906163; cv=none; b=mTmxr+248N9yhaTdbFBvUgUy4GQmgndovDSc4pj5bLc1L5i+m5KMIEKEq7UIkpmkDPSoHpsmqb46k3n/3XWvsnMnGxyjoz8KfeDvDLCtbmg11/kwzA5+M1sMuyJ78gm9E/4WuusMqAVHNIFjLC2w98YyWYe4Y+mrfDHAoydi3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746906163; c=relaxed/simple;
	bh=/yGugloBJjOPYsW7G1LloM/bgQysm4Goabb2TS0uuR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M5ONzN7IWi2PGWYhGEszF+cBmoB5CrauLwMMjI7ZeCMOIxakNEty8KXRw2dwBYGXgmsE3hpZt8TLcrAPfnmiIqxLhJjc2aPo2WDdeABGJf8zFDCa4HzltCtnHOf/AdcgBPPXMH2ximnrlNQvjCU8soJe07CaQhxjhDBWfjbOJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZOxXfPP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7423df563d6so1823759b3a.0;
        Sat, 10 May 2025 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746906161; x=1747510961; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoUcwGY/R3cNZfS/qBHsbioe5Np0VUp+LEp6Z3RV7R8=;
        b=PZOxXfPPkXWDloUgyf9rSav3jb56kF7PxiDgm9328yVvhxUdeZf2k+gfBoh9glbsNr
         FapPoBpxKshfqLaC+H4kyzOcULOrsnUymHt3gNF+scVqgzfN2ooQp7ktt+B4ZSe202v/
         Y7G/G818d5vMkGgtS4dy3iDshiBNR3FeA3Z0rb60i8AidXHg7+am2BBwJmZ5/EREKWmR
         yakko8Q5YHusqrRJICqdehKNKL6iTxiU/6B8277bOA0+m67LHyEpgPBCSLrLMnX26OxY
         rPD/UctUmu1DRA5hfH2R5AgpbM76eVPODzg68O/sgmdB2/r4F4SrZrEJQQJnhkFwa9VK
         tMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746906161; x=1747510961;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoUcwGY/R3cNZfS/qBHsbioe5Np0VUp+LEp6Z3RV7R8=;
        b=H1S7Vw+/ugquLCySvK9oTERDQq4aM2ugi5cqLzZWXQLU4dJaA8mldFcaEVrh58/XF2
         qOMHTsUduZTeQ5zRVTWpXXuUpx+hdDDX8DfW44E//DulVgSbgcqJ1gR0AHfJ9gFNWlN1
         lDofT2rlkmfVhyH+zmroCcNAp762SJVyoV6o44NoZGYp48tTZYRMof1tNUrGmQNHqZMO
         3vFAUOZP2GjQjU3YcRwIdnl7KOemj/H1VcIZil2hHdY226A02Z+jfFTUbRvKWKHNvsQM
         GnezQSAoztjj3zecNp57SgyZqIjpE8w+aJcVQswlxLq5XHYi0p3RtjaWeYqliFGRyIwI
         Uibg==
X-Forwarded-Encrypted: i=1; AJvYcCVG/Z2VUT+VWHqLZUNX0E9ZlT49DOX80VhVX+lCgj+MuW4she2ccfuqGrZ8sCDGZv7oFriwQFtzRfFwRjSC@vger.kernel.org, AJvYcCXoZoLu7NWuT0XlqPT5QpWS769weUA9JUuau8CduTDmO8oj+dDJ73q/zlr5lNXl124M7VGZXwlbalh0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Mf7p2sH1l2IA7PRiGCYAiWMHcpG/aOexeD1FM8uInMEMKaXM
	/fn2BngSqmouPXaPS3lrM56rilMEbuB4eIl6dm5NVAbhuLsWPNw0
X-Gm-Gg: ASbGncvxoCAPHIycrM44KG1l/lvXM3/m5OSsnxwF5DnHgSu240N4pLF+u8O+RJpoVgP
	geN6WIRV7lM5g8F1zt9/TwzNoL9o1x3KRHAnUN3hbfTR31T5cZxy9V3VkgznnQJBk7kDc07nNuE
	fzq0bnM/G9s6/0/tO6hIz8/FZQhSZEb3lAgJA2OFjl9rBTtPw0SuUmAJUVe6Y7hbkBjBfJdaPL0
	QOUOoaM3Ywt7j9XuEs+dXPDJeep02bKqQcAdwYZGFRybIoNTrL9chYLyMgnA3wb7osfu9cd76Kd
	A6gaMqXRc8Jkm8F7qupJ2Ymu9t4q1+J0c/cWbumwjDpykTu4UCkSF1D9+h/EG6M=
X-Google-Smtp-Source: AGHT+IHyaOCg6nmdx1tpmmDVVi4RGIofai7lhOL76Jh1bNi0mXY+p+TyZU8dD2IPM4g1icTcfEtCkw==
X-Received: by 2002:a05:6a20:d490:b0:1f5:884a:7549 with SMTP id adf61e73a8af0-215abcf3a0bmr12342972637.41.1746906161432;
        Sat, 10 May 2025 12:42:41 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2523e67d53sm2223670a12.19.2025.05.10.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 12:42:40 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 0/3] mtd: spi-nor: Add VIA/WonderMedia serial flash
 controller driver
Date: Sat, 10 May 2025 23:42:20 +0400
Message-Id: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABysH2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0MD3fLcEt3itJzE4gzdJIOkRGPTNMNE48RUJaCGgqLUtMwKsGHRsbW
 1AO8IJ1xcAAAA
X-Change-ID: 20250510-wmt-sflash-b0ba35f1a3ae
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746906149; l=2148;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=/yGugloBJjOPYsW7G1LloM/bgQysm4Goabb2TS0uuR4=;
 b=qKl34F1ulpROgbhFtip/Ntb7igCmTfhWuTyH8JITUi/hXyBS3ZnQ3a4trQoLk0edNiFYMW1sI
 OdnJDEsF3tECR0psehALNSioy48Rb4R8KLLibVLCS21GuvBLfWuNryn
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Add a driver for the self-contained SPI NOR flash controller found on
VIA/WonderMedia SoCs, along with the respective DT binding and DTS.

The driver is a clean reimplementation based on the Linux SPI NOR
framework, although only chip probing routines are SPI NOR specific.
The rest of the controller operation is abstracted away behind a small
set of MMIO registers and a physical memory mapping for chip contents.
In fact, the vendor's implementation open-coded all driver operations
on top of the MTD framework directly, but had to rely on a static table
of supported flash chips indexed by ID due to the lack of auto-probing.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Alexey Charkov (3):
      dt-bindings: spi: Add VIA/WonderMedia serial flash controller
      mtd: spi-nor: Add a driver for the VIA/WonderMedia serial flash controller
      ARM: dts: vt8500: Add serial flash controller and its clock

 .../devicetree/bindings/spi/via,vt8500-sflash.yaml | 122 +++++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/vt8500/vt8500-bv07.dts           |  37 ++
 arch/arm/boot/dts/vt8500/vt8500.dtsi               |  34 ++
 arch/arm/boot/dts/vt8500/wm8505-ref.dts            |  37 ++
 arch/arm/boot/dts/vt8500/wm8505.dtsi               |  21 +
 arch/arm/boot/dts/vt8500/wm8650-mid.dts            |  37 ++
 arch/arm/boot/dts/vt8500/wm8650.dtsi               |  21 +
 arch/arm/boot/dts/vt8500/wm8750-apc8750.dts        |  37 ++
 arch/arm/boot/dts/vt8500/wm8750.dtsi               |  21 +
 arch/arm/boot/dts/vt8500/wm8850-w70v2.dts          |  37 ++
 arch/arm/boot/dts/vt8500/wm8850.dtsi               |  21 +
 arch/arm/boot/dts/vt8500/wm8950-apc-rock.dts       |  37 ++
 drivers/mtd/spi-nor/controllers/Kconfig            |  14 +
 drivers/mtd/spi-nor/controllers/Makefile           |   1 +
 drivers/mtd/spi-nor/controllers/wmt-sflash.c       | 525 +++++++++++++++++++++
 16 files changed, 1004 insertions(+)
---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250510-wmt-sflash-b0ba35f1a3ae

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


