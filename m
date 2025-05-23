Return-Path: <linux-spi+bounces-8265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0BAC218B
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 12:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8285D7B3AC3
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1A22A7E8;
	Fri, 23 May 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3oRe6cP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8B14A627;
	Fri, 23 May 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997700; cv=none; b=Y4lrlpyt1KmA54hMQ6PAklylzLwmdA/hYYx8YpVV5z5ewlVBP97mjGH6+9usqIM+8i7D8sMWq0TloUte70BLMlCZauhwc+qWhHeLYYYaLWiEgezMUxQcvtMpV//YzVw4EOWkCaK1y9AWXcXDpjSFhn/cGycYyLbWgDsCC/5L6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997700; c=relaxed/simple;
	bh=PDAjNrHei5clcEsWtlb1tcKXX5+6Ez534sPDENqfREs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkzLCqVhqDKzY4liuW5r/IqGrY98KzWqKXbTLoZlr5sLQrkL8S3zsEJAFOvfrMbaxLeNevbdBO/Vl5k/xH3uziIwIpJcgZnW/dJbSIT3+inAXkqEBWqO9EqHNddeIH518fYWRQ6A3rVyD1ODaoVeJrk5GbZnT0v1G/ijDlk1q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3oRe6cP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74068f95d9fso7863302b3a.0;
        Fri, 23 May 2025 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747997698; x=1748602498; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gx2NMAGILchCpYDTM4FKpaWOrSAXV5ZVZLo5ud4chIc=;
        b=d3oRe6cPvZ8ZrweVI2dd3kNXjYc/BzsbSi4hnuV/n7AdfC37EWEpgnVnt3AkWf7fgo
         j7dSlERAEnKt1eHD65XMzYUuHyqtpYVGTeQMbzHIHhgEoAYROrY21wgmBMsgBx4Aaqp6
         DkZXfE4XmMOCqaHVeF7eX6Y42n2AscB7WY0AVKQwh+hf4XBzXAvmBVKLvaB9QM/Y4z3O
         VLeZcAcm4G4sAFSGbWh9FNeUbaRi9iiwbCWbxhpI2p9CWRYfznVzdNkwcZDV10ouJnbs
         yMv+zdYnIJ6+DyesmeFSvQRUqEGJjeUB6MsBefb7tdrFLOQoRLjDTPK35kZ6FUKEAX+i
         VpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997698; x=1748602498;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gx2NMAGILchCpYDTM4FKpaWOrSAXV5ZVZLo5ud4chIc=;
        b=UA9HZmmjgNGiZoEA/UkhiTJcsq0P7T2bqqaLn9TogbqNyCkfrM4EQZOE0558zZTHBF
         7es2jpRT3ixTv0DPOto/XzWoDnVZOcg3//7tW0D0Qu8eP3zaWWe3kvG1vVORoSs0ywLW
         OigU6zkdEJuHIkubwonAGS8YRo2aEQvDSiums5O5+4Sa1KhjKdribsF+d4TasqSrLies
         ypqAJ7umrM4KmodIozFuzj36QfrvzqTVZV81ZAaa14a+rbMQXhsd9aQGGWlks2j/qmrn
         94UYPQ5TbGuBrHW9880bzBnOhQriO0aDucY9BhSo2ruKi23ocuL8XEAOg433p2CGpQpB
         ee5w==
X-Forwarded-Encrypted: i=1; AJvYcCWTKGgc6KfPtHqpiEiqs9W3u1kQHFK1CfXE0J8kT6Rq13OUhB8+CPLTgy/AkKrlX+vqrqMGoEAGopgj@vger.kernel.org, AJvYcCWbxrhQKDy1PSwlUTX7GLRE6QERB1RqMDAHvSZeTWksstd+KQdyrZXDNZU25MuYVdR44jD2n6f3BB9Z+O+W@vger.kernel.org, AJvYcCXXBlCaKJD8BqyAwD4HTNGdJkRahZ+H403ZP+M1LY/BL2lH17Q9zA2kdJCv3EUeUDShUWEeD6GzwNFe@vger.kernel.org
X-Gm-Message-State: AOJu0YzXY23TVsHdXVONrYq+TQeG6X9TvhfxtTdFzx7lDBDWSo6rMX6D
	3F1yHPHQQsG2nndt80dSUNWzTsEarM/zi9oVMTxHPbVW/ZYMVV4AhlqX
X-Gm-Gg: ASbGncsjNqeWa2NN9l4Z+ncUqVT8ceK+S5fYvkEdsTVc4yCEtv5iJYxDtiLERqKgEAA
	1qKMZzNIQNLcr27KPpuLPiRbQbOpnvdDAd47OjXGiIZZEHLRKAix2jajopYlqM0wvcDvpY/S934
	7Za2t+TfZtDT5CM2g8VRt2g3xzWo7++RvU0I9/UwpPF/ybh/w1lkvjs6LfMsCUY6Mpap3qjKoFz
	Fyf3/Wcp8l+DZPmD8A5bI+YXJFXutS3zcOV99eJetGc26t9C4AC9XghaHbIMdtvVaPkl1ZrhPro
	kIMEFT1NxXNxn4Vsu204gY8h8fOZ2oD33pIiSLvqTAc=
X-Google-Smtp-Source: AGHT+IFypCY7WCS5VRqKJwgRs1MNVp/Tllo9WTcuJPwUOgHY8A/NI05aS1ZGOdCAv2mrHaxVdZW0kw==
X-Received: by 2002:a05:6a00:a06:b0:742:4545:2d2b with SMTP id d2e1a72fcca58-742acc8d18amr40326934b3a.3.1747997697689;
        Fri, 23 May 2025 03:54:57 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739cdesm12623687b3a.82.2025.05.23.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:54:57 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH 0/3] spi: sophgo: Add SPI NOR controller for SG2042
Date: Fri, 23 May 2025 18:54:48 +0800
Message-Id: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhTMGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyNj3eK0dN3igsy03GRd80RLQwMjS4NUSzMTJaCGgqLUtMwKsGHRsbW
 1AHAnD71cAAAA
X-Change-ID: 20250523-sfg-spifmc-7a910290e964
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dlan@gentoo.org, ziyao@disroot.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747997691; l=922;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=PDAjNrHei5clcEsWtlb1tcKXX5+6Ez534sPDENqfREs=;
 b=CCKTQTavAwLlkuUXuY4stTPw/85OwemMYUtj6yfdOghqgply89hsXdfJBOkPcCTT9xLG068E0
 Ryh10IHN37YCfwX2Hooj7pBf4WL3JneGkc2cee05xx17dzdi6drcjE4
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add support SPI NOR flash memory controller for SG2042, using upstreamed
SG2044 SPI NOR driver.

Tested on SG2042 Pioneer Box, read, write operations.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Zixian Zeng (3):
      dt-bindings: spi: Add bindings for SOPHGO SG2042
      mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
      riscv: dts: sophgo: Add SPI NOR node for SG2042

 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |  6 +++++-
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 18 ++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
 drivers/mtd/spi-nor/gigadevice.c                   | 17 +++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)
---
base-commit: 99d1d6293ed114e94253ec8b71f57b6c8d938dfd
change-id: 20250523-sfg-spifmc-7a910290e964

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


