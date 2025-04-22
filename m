Return-Path: <linux-spi+bounces-7701-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C5A95C16
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0053ACB3C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93841ACEBB;
	Tue, 22 Apr 2025 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aoz8izkN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424ADE567;
	Tue, 22 Apr 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288844; cv=none; b=qfqDvTcNw/S0FRokxahuaf131nIJhgMeOic9bhTC56chlIFSmK2y4z1z4chlixtDyNRWQRxe/8WE0i2ELL/23+uADBO9N6Bcu7kNhUA0KIFwAF7FcfdM+Pl8W+ttp+Yko8T+DadYq2/Le3vSooLfrsRc/mEBLYHIfBERFQUQQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288844; c=relaxed/simple;
	bh=6ruMT3OdM4nY9Z0xw4P1SJg0rahSN0BTucJQnw6em2c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BBl7h2qDmJK+z5GTxYFPqIPfEBWNfUxQ9nJBoFVaLR5jpZPlboLQwkpinSHaHuCGEzqyPhCtpzSonpigAm4/KriJga4Qq2eHmOxR712n3oKMceVulz4qHdqxyqDR31yv7UdcK1GG7oE4yo9ASwCShd3YBY2MQxNAXAeC+fa2O0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aoz8izkN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227cf12df27so40388795ad.0;
        Mon, 21 Apr 2025 19:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745288842; x=1745893642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ6lBxALj1e3hUxjwMwYeVCjpq+uXRd66ywkq8grLp8=;
        b=Aoz8izkNg7BIPgzoK4tJ9MjOXAQ3MiaS7dg3Qiy5z9+ivBf4In1DCGzOnasua9wFfW
         iJx1qgsm1EUb4JqhjKnFmB/vkfw84yY1CIZOYZlcqYpAdYO1OSl5jiDI6LZJxZ61HvY3
         F51+DVKvZDDZSnOOeU+Uvmtc/Q5ysMcEG/hzlIiuLpytdxhFovAOCxqBzSAhzOGTlxkt
         QK3cFAhFUyVIRaxmUa5HFOhY/QmbG9OxhMNoJsVbqt8vOSzjqSa8oEJNbJjJpf6jGT9q
         e0ICv9pjZmIU/4mFkiKwwJBgD3glcTa7S7/lFutCXyig0B0Wy8RvI524C9WEN1SIYlR5
         KhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745288842; x=1745893642;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ6lBxALj1e3hUxjwMwYeVCjpq+uXRd66ywkq8grLp8=;
        b=D+RFtQ3myU8JubKV9GgqHlln3+d1hwg82HMV2BHB60Sd4zOgC6vtYuyrnAkRVnZQom
         9jBD8bauKyd9W2cv0E0vySc51sHJU5QslwXQcFZxbsF1KcGzRYuRtyHb3UBkRwVyySRz
         IS9dsnaa2iHCbKE+IfBV09T2Nd2xIVu4PG33rMDi98zrFeOG+9KbVse/3jWt3E+zBbQK
         7UGrVT0RRSiWVa/jf0ztc5daOftYDyv0i4pqJyegVz5Ls8huexsELbMsvdigN+5cklOC
         fcNhZkwEFDkx8ZisvS0piQ2drxmr7rf8HEG6Oqc3tJYZtSo1rDUv0LN5p1kJihmEOtM9
         aASw==
X-Forwarded-Encrypted: i=1; AJvYcCUhVwdC2AtpP4D5zzwKgj0ZXV8SDw7g4zbrAZAz7c/VkoZvdzcxyXBGcOjoLKtFLkMU5yl97Nn/XPGj@vger.kernel.org, AJvYcCWGG+tnN4zG73+bsAe/XxUiKwNrPttkuL0JKXxQGUqjpLeQWlrKhHz5nY3dZdxYKVkpSNAaMDVp6dE4ABaXxI02NLc=@vger.kernel.org, AJvYcCWKqSAWJ5hgGriPBl+R7oyakJF0W0ayt7PSCwm6+CMCYRzPrRkxugODGJijNFpz3BZKYmg3BCAGnB0dDdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZO6ouhdpn5H1poR+ur2dGa1HGyd+2QgzKupNBXYW77UJQew+b
	fbbYEGe6FgvDUMbvZ3l8NCdzy+v8vyNEY/o34FXzGT9RPhRjraX5agUlfroSJ/udKg==
X-Gm-Gg: ASbGncthKEkliXzBmsyXe6WsPWpKRCTKb+qrhPc1gqk2PO6EQHa00NmBdXtsgUBP8Yo
	6qCVaMJDxBWvhyRdu/bb58F1Qfzisvkod94wYuqSqLUvA3ff2cOCZUCGZEm/aDm1dhGRWv+r6wb
	uUd237i4NAiK3IVpsOLYJ4yCFGT2LTKgP7h2x5YYgBDGkSexnQNdVTe7nzObyVElxcTN+2lVwC2
	MzE/gw4tq86KXLV1+owyujl+9e27u56OrDFX8G+7DWon/pOkcrQ3czWewlxJMDDSlKaOurxhWsG
	V/Mj4tqSYNyfpdNkxtLtz3GMdDCyeJNcXiTjREwunxQQTHBU4/m6hGSRvv4=
X-Google-Smtp-Source: AGHT+IE8s/PFyhjhaPYvt6bB4xUY2xwxqA7TDLSF0+XalAWL5s37/k3bBFnYGUpM6h2mO0zvjsBAyA==
X-Received: by 2002:a17:903:1ca:b0:215:a303:24e9 with SMTP id d9443c01a7336-22c53e1a14amr189152745ad.3.1745288841169;
        Mon, 21 Apr 2025 19:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4ae9sm72962905ad.110.2025.04.21.19.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 19:27:20 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v5 0/3] Add basic SPI support for SOPHGO SG2042 SoC
Date: Tue, 22 Apr 2025 10:27:07 +0800
Message-Id: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHv+BmgC/3XOTQ6CMBCG4auQrq1pZwq0rryHcdHCAE3kJ9QQD
 eHuFjYYjMtv0udNZxZo9BTYJZnZSJMPvu/iSE8JKxrb1cR9GTcDAakA0DxUNQ+D54QVWCqsMNa
 x+HoYqfKvrXS7x9348OzH9xae5Hr9bUySS+6MNpZKo4yU17q1/nEu+patjQn+OIhOO1cBOp2Wg
 o4Od4cSd4dccMp0piBHqRwcndqdEvnuVHQobBE/aSVh+u2WZfkA/FtuWkYBAAA=
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
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745288836; l=2109;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=6ruMT3OdM4nY9Z0xw4P1SJg0rahSN0BTucJQnw6em2c=;
 b=Kj1qEicqpG/qzfM8OeIPXYUsPfB0PdPORtKudCqG7QpQxQ0XMb8oe6nVkuDtBB7dm46FpexHj
 NO49kygB3CsCfxsOrjUleGzoqTipOVfWhsD5zr4HT2DxYinoxMp14Uz
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Implemented basic SPI support for SG2042 SoC[1] using
the upstreamed Synopsys DW-SPI IP.

The way of testing can be found here [2].

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v5:
- patch 1: New patch merges all vendors fall back to snps,dw-apb-ssi into one entry
- Link to v4: https://lore.kernel.org/r/20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com

Changes in v4:
- Adjust the order of spi nodes
- Place the binding after Renesas
- Fix the description issues of patches
- Link to v3: https://lore.kernel.org/r/20250313-sfg-spi-v3-0-e686427314b2@gmail.com

Changes in v3:
- Remove the spi status on sg2042-milkv-pioneer board
- Remove clock GATE_CLK_SYSDMA_AXI from spi [3]
- Create dt-binding of compatible property
- Replace the general compatible property with SoC-specific in dts
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


