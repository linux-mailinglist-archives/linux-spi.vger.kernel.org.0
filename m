Return-Path: <linux-spi+bounces-8664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E36ADF798
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC92F16B112
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835921ADC7;
	Wed, 18 Jun 2025 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8HqFDuw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3293085A6;
	Wed, 18 Jun 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278187; cv=none; b=TZMusOR/rYg0+6dcQsljmfPDZJD02/8nJsJnjrmICt1psWNPwbEBnzvdw7kIbbzzWwdDCB8N5XU+DNYutgk9vAykgEJekRGEdHID5sCAbBiorhwe2hvJxxWTL4KqtnQd0pBVdTIqD0sx2kJZkCoMMNxCTHzWcvXthAiCQccWn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278187; c=relaxed/simple;
	bh=TdUtYEhnQdQ77j1KGrvr4R8bCHthVyxHQ4vv3bltKf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tT/guytVAjQ04iTVvtpwTWsNwLyEj2K3onMMyBu+0ZOUd2k2utLUHurA5W7tlzDjHMlqaCuNnYGb4+IFtAug6U5yq7bwowzX7nD01ml90J7jKPoCs63yiJIL8iLx9j0UMrQ/4aNQrdZCeRW5xkdb6kJzdif7X4ZHTnAvguIkV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8HqFDuw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so52813f8f.1;
        Wed, 18 Jun 2025 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750278184; x=1750882984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdY90JVNXT4QPFohJuCx2RaKTGnu0SRF1dWwzgFg3Ls=;
        b=F8HqFDuwwKNIa7lRS0tZS3exIe5BOoQvZ1zr3KIMzbs+rpalIY+3kU9enfozI63bS/
         gxtgtsRr3zXIXosSBgWTAeK+HBUbv+SKQxnt0g2Cw0967OA+6WoWuyS6OlMrSIkiAKoi
         wKIbsgBwxD+ZYZ/J6zYZc55zcT1RFmvSobSETwiTVsWjJJ3DQDrMi3WcZ74y2hh+t230
         QwxK4HDrTZrrivAHWdQ1LsJYWGCQ7YaDwtN4W/tGDgiRQY/kzYa5GNl14vcEUvWCFke/
         BwgoO0o4qY1YyOzUDCVFl8B7XQOHQQF0wC+uoMyjb2FEDVVuNzOADSFm9i6Ss4dauGv/
         B6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750278184; x=1750882984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdY90JVNXT4QPFohJuCx2RaKTGnu0SRF1dWwzgFg3Ls=;
        b=fy1Bbl0ejSuTgwQKlauXYM5Y4YJmg03ZlBYHzeUZJFfAlQerQRlGGYLyK2hvb3CNJK
         0DNa1GCLGq+fjsPmYPyMwEz/ejg76sl3lEfGG/OigZju73uTJWnHy5UqPnXb9d/XeaM1
         qgIYxy53bZGoht4G/1Qe4aOmVcX3/CiL528c/KhTYgIVatdZ8GX03ASPpmBG1v+Kl5dw
         FizWQB1vOjrBy9HEeOSNfwQvQavlI/r+ldXwSAs2CbCwIt9fMSbjiCr2TrPNW9+cjdSo
         xttqdYj+mpz1dlCQRvbl7NdI9IyIo+RzbPW3VUyRdYX9i4Firb5nPcc/VS+HyvgyP7aY
         4wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjCkk8fvhvGiCK9ieK0sbO0cHWfgP5y6adWHxF4UO6eAArfSrp6oKH0kRyaBPYMp8bChy3JB5AJJekxrmq@vger.kernel.org, AJvYcCX4mkSZlsQe3vs0BTkzDfCaoqxbOHO1xR+p1yQGcBu8mMQnreM5WOfGnH86Z097D/1PKvBs+EzaFlpl9jHY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/c23DqTJMaMkWZ41UfeCQkiqnMqhS17meLlQcrRBRtcNK78XM
	9HSyG0lidjqLXSaKqWMubu8JtrKfoQFDYlo287DIvlgbT7SERhbracr5
X-Gm-Gg: ASbGncviVq9f9PVTxGWZf3w+Vf4vKo/CTq6c1lhxV8tsexhmiAdMRcG+Fsxlc8398Q4
	XMvd0RO56AwdJGEfFu3rGHh6OaqsR4xPtK76CAwqIW9+PvquxR1Nl9exVdG34EdIq99tb7pRch6
	8ZPNX7/KkKZmxj99X8IPX2DHGnmfJ2K01k4thaaGBk+a6fK6MG1h9CBwPS0WKxFuIba387JeWpz
	XmQe87FSvzkF9zHntUPS/1ai4VL6yaiQuDaa/H5zwV0QcUTe0X+JzlG5uZ2jrNzl6iJglP+VvVF
	MimNc1Ae09gdUZ01MNoeYo5E9tO1En8YiRFMarICBHgJEjgP39+UO8PpXhoj5MfZ98yfMNXtkQp
	ZNSRmXRkOwPogulc=
X-Google-Smtp-Source: AGHT+IHoejpqZzdcxb15o9qORclA2awd92JClJvR/ZCPZyDuQip+yhKFOk2EIbxVxD6hNuRNxXHhbQ==
X-Received: by 2002:a05:6000:4305:b0:3a4:dbac:2db6 with SMTP id ffacd0b85a97d-3a572e553e0mr14325235f8f.49.1750278183806;
        Wed, 18 Jun 2025 13:23:03 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm17617951f8f.26.2025.06.18.13.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:23:03 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v3 0/2] spi: spi-qpic-snand: avoid memory corruption
Date: Wed, 18 Jun 2025 22:22:48 +0200
Message-Id: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABggU2gC/4XNQQrCMBCF4auUrB1JU0LVlfcQF2kyaQdMUpMal
 NK7mxaE7lz+A/O9mSWMhIldqplFzJQo+BLNoWJ6UL5HIFOaCS4kl6KB50gaklfegMqBDDh0oEO
 Mr3Eqv9DwWlnVYcexY0UZI1p6bwu3e+mB0hTiZxvM9Xr92fKvnWvgIC1KcTJoW9tde6focdTBs
 dXOYu+d/3uieMJyUzfK6taIvbcsyxct9gZNHgEAAA==
X-Change-ID: 20250523-qpic-snand-avoid-mem-corruption-301afabeb0eb
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>, Lakshmi Sowjanya D <quic_laksd@quicinc.com>
X-Mailer: b4 0.14.2

The 'spi-qpic-nand' driver may cause memory corruption under some
circumstances. The first patch in the series changes the driver to
avoid that, whereas the second adds some sanity checks to the common
QPIC code in order to make detecting such errors easier in the future.

Preferably, the two patches should go along in via the SPI tree.
It is not a strict requirement though, in the case the second patch
gets included separately through the MTD tree it reveals the bug
which is fixed in the first patch.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
  - rebase on top of current spi/for-6.16
  - add 'Acked-by' tag from Miquel to patch 2
  - Link to v2: https://lore.kernel.org/r/20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com

Changes in v2:
  - collect offered tags
  - reduce kernel log spam in commit description of patch 1
  - remove inline error printing function from patch 2, and adjust the
    commit message of the patch
  - Link to v1: https://lore.kernel.org/r/20250525-qpic-snand-avoid-mem-corruption-v1-0-5fe528def7fb@gmail.com

---
Gabor Juhos (2):
      spi: spi-qpic-snand: reallocate BAM transactions
      mtd: nand: qpic_common: prevent out of bounds access of BAM arrays

 drivers/mtd/nand/qpic_common.c       | 30 ++++++++++++++++++++++++++----
 drivers/spi/spi-qpic-snand.c         | 16 ++++++++++++++++
 include/linux/mtd/nand-qpic-common.h |  8 ++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)
---
base-commit: d57e92dd660014ccac884eda616cafc7b04601e0
change-id: 20250523-qpic-snand-avoid-mem-corruption-301afabeb0eb

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


