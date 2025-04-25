Return-Path: <linux-spi+bounces-7750-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC0A9BCD2
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 04:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE5492358B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5614A0A8;
	Fri, 25 Apr 2025 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9SSKVW/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D154763;
	Fri, 25 Apr 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548114; cv=none; b=QLs15b2GaOf2bzLG85/9uAsI/q8mc5ktdiKkdm0xDdfPxFUtf51qSo+SEC4LQGzrOPPPqurs48gSjSqXrQdraEpA0rX9UIXslXrXs62sxJcJG13BucKthlNr9n2kEj3mi5J+Fy9t1h2VimkOk7F8ZcXpGvH/qhjjsiWhcCqdH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548114; c=relaxed/simple;
	bh=8wmermrE5M1bwblIgtOTe7sR30SfNY0obp+bchFCYvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CVx3xO3Dj6ndqR/ZXw/BPmPtxU0CUie316PzA+6C1v+G37GtIGfqrgzgqkCIC7p+/+lgGc70CJTdUSNaVhxYTVZOmBRA9OED92am4WxSXMkiYtHdjBWLRANp1nE2toRhBc/p2TdCFOxy9W7lmBSKbnTfFudUwrgEfTSJoXLHynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9SSKVW/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so2338172a91.3;
        Thu, 24 Apr 2025 19:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745548112; x=1746152912; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWs7czVv33WD5QwKCbEc0JN2+JAvd6m2fpFPVxVDwgA=;
        b=E9SSKVW/deVLSlCnLjwCypFMD0LZcgKwFY5ITVAKcu6RtoSJgfz9GvHxjCUUijEJvZ
         1csKa81759GYeqaXmcHBG9d0fJZkDhZqozl0D82jAnSBukKCv4aAGwd9VtMBty5Exmfr
         LMyDjmNYaAzvFYVOfD+3Q5IsoguD3fdr4nx1dMqXntREiBwRl/Xvt3vAStnRBg4k6RtT
         F8TpJ++x7dbAiIidsPHg7mJcmVRz6i2gFOW177WWH4IY8qtECaMFnSbYUriLY3BdeWjJ
         VOHa4t7XGhKJcC5fDN1siMnYGoFMfT6VR/SnW0OahGg0J8b7t2Y3UXjeWt78VJE9JF6k
         X4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745548112; x=1746152912;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWs7czVv33WD5QwKCbEc0JN2+JAvd6m2fpFPVxVDwgA=;
        b=Touszoj6PDT2W7aIgc9kfxn+YdtZ6em9gOApZtPM58ss4x2PqjrQ0lMbNk8TA1b+4t
         3GZmgSoX/vNnR7lSc9+/exMJEPKi8t5A+l26tr6Nk86Jz/Kk1F09I0+MfqjUCRFvoWBk
         DhVyVj4444aHIX7x81ApxI00N5JeU+sRm7/KdFh7HhA2O7yy+IM6VabpBGxZRtfKfLIA
         FgJMf7LxTlS2VtyQaMfj/FJYfmKu6jwkjMzsq5iMt/R3DAg1OGp9jaUyMZfBdnSTAAn/
         6e9nfOwGn/cQyJW2TyoHGPG3b1SsJCAqGZCsOpq8VaoVdlNQgOsWIjCBhs+LKMTm6eo0
         dDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUFaph55gMCVtLoWY86IBc1Kq66azwaZ3gsJl310Z/XpaQY3Yji8FcIZDK0BIdoLqo/oTBWnQrtsahyIK8=@vger.kernel.org, AJvYcCVa41uw2RJyUtHytTLOozLLDLhUZWdFjtfmkTOVrAqnzaT7LAqYrL8PcWtOd8xFduFLgYMX8KWE8hQR@vger.kernel.org, AJvYcCWg7uXIo4mCe/dTPwpqD5so31ho7WXB6KAm4SJuMexzDpsWTDtBlPR0oG/VH4GrWAigoDweNp3H1YAf6LpJ4RFM9yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzva2FF2UiL5LvNS5/7UA6K6K+TkSe3v5zHqIwrDzd7EBlSDnJi
	daaHDxuaj+Y6RT/u/enz8m5a85+/ZPo+IVCWF+h39BvjdJKmqJSnCH+A9k/bIijfHg==
X-Gm-Gg: ASbGncthPCXbp6kZ136clIioqTGq6govYN7p/2VwlVyCMzOjnKcHUJtd91t5Jeel3os
	Me9cV5q/tNFCXSUECldaHrB9fvBiITRXqpr8KGmjNJbh3zSB+zNYHCpVYcj4XKpj5dIm0Ms4gGC
	R+/ZdDwAnOnIiDIET7BZIG1aGapcW/4BXjMZc5PLkzpDyRjWBVShhJrhn3jEs9g9JJa4MYt6vOU
	6akQpaY6cEe+UqgQRoASJZ7bQ9a0IRz5bl1gpjEYJZxCCgjtZWyyqL/T7BR1h4JPPgvzkWxo7dq
	A6SXe9KaFUcDnUQBg1PyRqpFwC7lYGd5OxFR154psgNVQaaj8m+fh2d3
X-Google-Smtp-Source: AGHT+IGXRHecCFcL64rpDvSNx0T+kbwJIyVpg8y/+sbcGf/XoI8mdp3d7daOKwWfUyt8OoeRaQFhdg==
X-Received: by 2002:a17:90b:4e87:b0:301:1c11:aa74 with SMTP id 98e67ed59e1d1-309f7e7027fmr1187414a91.28.1745548110992;
        Thu, 24 Apr 2025 19:28:30 -0700 (PDT)
Received: from [127.0.0.1] ([223.80.110.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4a9sm365455a91.30.2025.04.24.19.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:28:30 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v6 0/3] Add basic SPI support for SOPHGO SG2042 SoC
Date: Fri, 25 Apr 2025 10:28:11 +0800
Message-Id: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADzzCmgC/3XOQW7DIBCF4atErEsFM2BDVrlHlcWABwepiSMTW
 Y0i370kGyJXXb4R3y8eovCcuYj97iFmXnLJ06WO7mMn4okuI8s81C1AgVUATpY0ynLNkjEBcST
 lKYj6+jpzyj+v0tex7lMut2m+v8KLfl7/NhYttQzeeeLBG6/1YTxT/v6M01k8Gwv846A6F0ICD
 M4OircOm0ONzaFUkjvXGehRmwBbZ5ozqm/OVIeKYv0kaUa7dfbNATRnq4t96qw15A2pd7eu6y8
 oCkCYfgEAAA==
X-Change-ID: 20250228-sfg-spi-e3f2aeca09ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, linux-renesas-soc@vger.kernel.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745548101; l=2302;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=8wmermrE5M1bwblIgtOTe7sR30SfNY0obp+bchFCYvQ=;
 b=7QwgjA4uNKIVGLxb1ctjXPQAAYavFTWZ6Y6YdPmSoLAuI9YIU1Ytgaum4LNiHoUPTHn47KJ97
 rmaiwgO+wpHANGbzaIIIZcQtR+VK1L9NU75DipCTetUZKEuV4xbdVo8
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Implemented basic SPI support for SG2042 SoC[1] using
the upstreamed Synopsys DW-SPI IP.

The way of testing can be found here [2].

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v6:
- patch 1: Apply Krzysztof's tag.
- patch 2: Adjust enum to alphabetical order.
- Link to v5: https://lore.kernel.org/r/20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com

Changes in v5:
- patch 1: New patch merges all vendors fall back to snps,dw-apb-ssi into one entry
- Link to v4: https://lore.kernel.org/r/20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com

Changes in v4:
- Adjust the order of spi nodes.
- Place the binding after Renesas.
- Fix the description issues of patches.
- Link to v3: https://lore.kernel.org/r/20250313-sfg-spi-v3-0-e686427314b2@gmail.com

Changes in v3:
- Remove the spi status on sg2042-milkv-pioneer board.
- Remove clock GATE_CLK_SYSDMA_AXI from spi. [3]
- Create dt-binding of compatible property.
- Replace the general compatible property with SoC-specific in dts.
- Link to v2: https://lore.kernel.org/r/20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com

Changes in v2:
- Rebase v1 to sophgo/master(github.com/sophgo/linux.git).
- Order properties in device node.
- Remove unevaluated properties `clock-frequency`.
- Set default status to disable.
- Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com

Link: https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/SPI.rst [1]
Link:
https://lore.kernel.org/all/CAKyUbwXqg13Ho7QHw8vV2W6OcObphwhQ8HUrZMDNBxrVxLmdug@mail.gmail.com/
[2]
Link: https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst#clock-tree [3]

---
Zixian Zeng (3):
      spi: dt-bindings: snps,dw-apb-ssi: Merge duplicate compatible entry
      spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
      riscv: sophgo: dts: Add spi controller for SG2042

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 19 ++++++----------
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 26 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)
---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250228-sfg-spi-e3f2aeca09ab

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


