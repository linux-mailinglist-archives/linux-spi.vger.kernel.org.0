Return-Path: <linux-spi+bounces-8990-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C746FAF15C8
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FE177D44
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F14D26D4E4;
	Wed,  2 Jul 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbhTbUlY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91461E485;
	Wed,  2 Jul 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459752; cv=none; b=Wu/nGoE5vWZA89oVWSDJ/EDO9gL4w8zPsN2iuaJhLd24jnnw7pYcXjc6Xp3+NLX/PVkCPLE/aC0pKuzVjftls3M/B6uUuOQ8w1EqViNMNYvSZwCvT5tcpwbmrb4TDYYZ179vhuoW1uXl2pKOwe0gFO7Zd8Np7KZRMHbhm7TlIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459752; c=relaxed/simple;
	bh=VTQYWgQLaorrbxmbb+xIR3t+bnZTz+/x9isjksDhFTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NKr9qEQF8SLXSBjN1xFsOmei+0s24TR4ee0B92ctHoDnY2WA11OpsVKGuX3RtiHyc1JXG/ce6ELepuFe8xHDQJCFJobPj64oPRdYtDMBHb0B2QBf9Io5DJ0gvVFwK/V7JQYHpem1a5DvLQWg9EGz2Ey0eOldJ/mJZM+ivQJLByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbhTbUlY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2922235f8f.0;
        Wed, 02 Jul 2025 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751459749; x=1752064549; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jg0LOIPqdIozUkUH06/iHo0/WcHNQMfp9668OgWITsE=;
        b=jbhTbUlYizjYAE5A9RY61Lgi/9O/+v7mJDg/yEEBaRqnWKcATent1yq24/sJq1J443
         KtExSFITHrwhGllAtFry0GN3SWVvwthUyyvta1AY5+ftfcS7/UJJcRKh7pCf4NTY7tnh
         lZaU/JBvwfm7KsnTaMqYoLxC9NRcuIqCdlyuzkxe9qlPQyPKVxG3ExytfCPamTuK9wv6
         jY0wngKGYclAihmk3XhyfI4xCpf4y86JRVe5WVxzXoKp/2NbPfdJmTU+I9a/KAi4AYsu
         ghL1nFbZw82L2k7rRMzzMBRozCP+0a5HtYsrXqw7RYnDx+6vvoJmvvq3fBig5moI1weI
         QIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459749; x=1752064549;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg0LOIPqdIozUkUH06/iHo0/WcHNQMfp9668OgWITsE=;
        b=jb78UhvkNys2SaCqcfmZaH8kY1Cewt6BvRJaIGf9UbXZ8CGMaJ0/QtXqEOyl8iH7DK
         2vbjRILqT0ccjs8sgRitlAHiTpKtjUyKQ49ynPscZi6dTv3J7CwDtqq6MR63DKa2BTNj
         5oOXRCXsYZTv8DIGNTdR267Qf7ClPI1VuvXaJlD/Cb1pNhvZ4MXt2caGaTVGyHBmDTM6
         at7PNVYAdpI7HqANQ+ISbuNB6v/CyY86X9cm3e+qihA6N2RNkh7ImbOtMehcfhksK7u1
         dmp2Fh9P6/yc1fYA2r8EdPJxW4CMswbVwcpYvLz+iZmJtKqWLUq2HNubKTBZuT6d8RBQ
         sHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0+WPWu6emBP7xfXH8DPvllJnFIzasC09Mn88XQ2pAbrPFFG0MBMuPv0wAKqXpWE1XIlFzlwVLy4ST@vger.kernel.org, AJvYcCUshQ/3W3PJsGFRrxk7pRaU5rE9GO/y8jiLBLkDX2YpboJqd71WsJdPpdfDWkd8XyqaQHCCId5f2niv6tJX@vger.kernel.org, AJvYcCW9TYctoq3RsrApqKcLv7+NsdO5yteUixL9mWR8w1isMzYY2kBihRoDnqwJLXyA+fLwC2sFnJRgFB+V7+63@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIE4EEg3zwo0X0oN5vprOS4CG7apWnGXL0muRiyeUd+7CEAF+
	xh1bqty3MPtgeSqC5/NeEz0+DMC1f6E5zzQbe7rQuN9iF3eE4ZQCYCSk
X-Gm-Gg: ASbGncudwOQGiAqBEaMSKc459SBVxOxnmZ+qVk2odz7gC7ty2PtGd59LYyVdTvtKqZI
	Fa3332+LtRxrld0KCEvwWTYjk/zo/IcEVqOpr2kQ9bdEPfUsvrYW8HgcEMekYTsDIuoQSS3DYxv
	9tUS6fPWoeyimE0RihhSSBdiARNFxkVfG0cLEVdP3EQc6cfXqvlnF9hhuTjlmHoDTQcbwL8fxhU
	qreq+yo/xbQ4XEar+WEtxwnupSotztfzyJhQh+6XNqJ5i3bDrLykzoZH2UavySe37Cy5JPRzQbU
	D+ttP4BUCOv3iK01bKrYQKwGvtSLHRdMWTAdnn+Mo+OL54c8WdfC1Z97MQPzbL1FKN4hzwJJzJc
	BW/jYiJptJ4ecyqU=
X-Google-Smtp-Source: AGHT+IEZ7JKobG7elvoBdLsbn735VSU4fEnUj1mgXLW4+2+SXlswXfAlX7UhudyRbE0dWHkfsFfn2Q==
X-Received: by 2002:a05:6000:18ab:b0:3a4:ddde:13e4 with SMTP id ffacd0b85a97d-3b20253882cmr2157966f8f.58.1751459749144;
        Wed, 02 Jul 2025 05:35:49 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8a0sm16208688f8f.96.2025.07.02.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:35:48 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v2 0/2] spi: spi-qpic-snand: enable 8 bits ECC strength
 support
Date: Wed, 02 Jul 2025 14:35:22 +0200
Message-Id: <20250702-qpic-snand-8bit-ecc-v2-0-ae2c17a30bb7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIonZWgC/22NQQ6CMBBFr0Jm7ZhabVJceQ/DAqYDTCIFWiQaw
 t2tsHDj8v3kv7dA5CAc4ZotEHiWKL1PoA8ZUFv6hlFcYtBKG6WVxXEQwuhL79BWMiEToSOrLrV
 T1uQa0nMIXMtrs96LnQOPzySffmMrcerDeyvPp++6R1Lmb2Q+ocLc1GdKoaoic2u6Uh5H6jso1
 nX9APl+Ot/LAAAA
X-Change-ID: 20250208-qpic-snand-8bit-ecc-dc804fd08592
To: Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

This small patch set adds support for 8 bits ECC strength, which widens
the range of the usable SPI NAND chips with the driver.

The first one is a preparatory patch which adds some defines which
allows to avoid using magic values, and the second patch implements
the actual support.

The series should be integrated via the SPI tree, as that contains
prerequisite changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - collect offered tags
  - rebase on tip of spi/for-6.17
  - update cover letter
  - remove 'next' prefix
  - Link to v1: https://lore.kernel.org/r/20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com

---
Gabor Juhos (2):
      mtd: nand: qpic-common: add defines for ECC_MODE values
      spi: spi-qpic-snand: add support for 8 bits ECC strength

 drivers/mtd/nand/raw/qcom_nandc.c    |  6 +++---
 drivers/spi/spi-qpic-snand.c         | 21 ++++++++++++++++-----
 include/linux/mtd/nand-qpic-common.h |  2 ++
 3 files changed, 21 insertions(+), 8 deletions(-)
---
base-commit: d2c0e95525216cdc695d0066ee2f70b8adfbc536
change-id: 20250208-qpic-snand-8bit-ecc-dc804fd08592

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


