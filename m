Return-Path: <linux-spi+bounces-8333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66AAC81A1
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43DA1BA1078
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E222E414;
	Thu, 29 May 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfzwpGDT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597F1632C8;
	Thu, 29 May 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539524; cv=none; b=cQRNPgL7iOXfhT41YraS74t8iF1cyY2qADJqmA293gayHm2d5XTOC+iqTHf4dNUI8w0tKJPhKAAa7wMFU2JKUB+h/vpBfLDDgAvSFUFpVLvcO8xOuQDcczB5w3Fah+RMorAXA6/AhcCNT1w8lMhmxGtQyxcZOt2F4u0R5LcrLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539524; c=relaxed/simple;
	bh=dQPZmlzhmVqwEc5qR/GIfGI+29MFbkSn2moMSyu2has=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bxhUCdn0JW/IDZDSk7CUI7qnZjO7g42NlQPhAtpwiJ9yfiOMjLAfTb+R7cq1D1HYH6ZTi+IeYIZQgM1gk6vzy9leD/oSi73COjVVNo+UqAwykurP/F55PTSIINty0mBtBKGu9qrWYgJRw9XzeqbtU5lmoP1bX8IeZbTG9f1Ptmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfzwpGDT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acb39c45b4eso170135566b.1;
        Thu, 29 May 2025 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748539521; x=1749144321; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zuDRW6dNj0IOWTOPcp8s+afnvWue4+ReSENfxrc7Ikc=;
        b=JfzwpGDTUUTmwmq4fT+jHBjlRNKFXJpjon0qziwGQEXTvVvjUxjcD4eJEIasP7z/qD
         BpWlKWOKs3ZQmXIxPUOjr8iif5d0B6mTW65QvyVnRLpC6Ba1374BJMaU3Da6TR8w8Zre
         mQoxJEbjwp/X6cq/eVLgq75g0qNpeYPBXoChlu+6y0zoairTPdV0b06TIecNGpmHmPRC
         ktChpDs4Wd7mc7Beskb1w0/2fZhYoWSeMP5J41rkc06CwNfyNjWS/fgixntygNuZI3Vr
         Gj9cPKjCf9OPfrGPHKfoYcXfJmxhE0KyNtviploOI+x5xlB+WGQSMTW7Oq2eeF+glvou
         B6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539521; x=1749144321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuDRW6dNj0IOWTOPcp8s+afnvWue4+ReSENfxrc7Ikc=;
        b=kf6U6ORy12pAlEeNHQ8IiFOLTPA5y4MJcGpOo6rIFoOCHT+/W7f0XzlhSDTbqMVLEv
         /vUXqIa/4n/MlDqzoO0kDgKlUeUtd+gbv3AN98b5ZNT/ClW2b8hbgNJa81Lhqy0TqYH6
         1m9vPcr65AUg7fTM2jh4fkHO6Yh2emmm9dHwQS4rkSRg7uELBizGIIyIJRK+Fa+AXOwK
         r8IbCy4jznrmBdCNALcOh6A04sJ3eIZQid+BWF6sZaJ+dB93VuaJ8h+dFWNa49zJyee7
         tU/i8OfRLtmNBrp6gpA24Pn8BScMwIW3ohNAK2/Csqeb2uMdkrJ80KJGsYNkLi7cX3Qr
         JJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+n98hWZASRsQ23wv6XnuSKzNqj+2TXwnZQ4lOjubJvDKyw+kGp6/k3ETZmVhbliQevOndhgz0V7XVg8LI@vger.kernel.org, AJvYcCXkMH/VJ3r+poBd0kScUlQXEMzkt+akxYLzsFIk0L5+nLFHnaBRej0cDPIdyl5mDVOn4NwSU9OoIX+sBlNH@vger.kernel.org
X-Gm-Message-State: AOJu0YxEliq+wVTFJjuq697huokGtCkkQ0Y2glS/lIxrrVOTi5op3T9H
	DXWk+FTkInuxO+PAGMh4t7j3KSmAWPnvU/OEuGRu3ROTo9HPl5eEY61H
X-Gm-Gg: ASbGncvSvnsU4ciFDa0zesg85gnRtzeQqX2n/YLMQNktT+laFV0edTVoFkq2Y2dGMhj
	+dodeuO+/gnmbF8mA7j6cOIT1Pq0oNab4hPBG41XGVTpsp1/z0aTBPfyI9b57Jtw4lgPbE2WfUT
	2UIjOY2cV4FddswNpun1MCCi0hc4crO0xIHrczQsA3FnB4kv2PyvdGScoWj+MSqWgVPnUQbX2bY
	3T1e5jqql2MmrZsyi9T1ELqH2ZwGfyl9BV2TV2XKO4xMivzJYbwM4YCPYb0zOmpVSrByAtuFvUO
	SOKMvZGbPuepnESRDhqhck5V26Os2ECz2Kl2SrDHICZF/+GDIGnhPfSI3WZ/RhM71ooFY3HFi18
	SFX7S
X-Google-Smtp-Source: AGHT+IE3tPbHzEot+7hFeyg0S5+wiBWgftUOvAeih6bJHDPmAVbEJrAG1T10BSS9j25nPX/oPKWAMA==
X-Received: by 2002:a17:907:9405:b0:ad5:a2d0:567 with SMTP id a640c23a62f3a-adb32450330mr21988666b.51.1748539520911;
        Thu, 29 May 2025 10:25:20 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ada5d82d95bsm177793366b.57.2025.05.29.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:25:20 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v2 0/2] spi: spi-qpic-snand: avoid memory corruption
Date: Thu, 29 May 2025 19:25:09 +0200
Message-Id: <20250529-qpic-snand-avoid-mem-corruption-v2-0-2f0d13afc7d2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWYOGgC/4WNywrCMBBFf6Vk7UiaEhRX/od0kcekHTBJTWpQS
 v7dWHDt8ly452wsYyLM7NJtLGGhTDE0EIeOmVmFCYFsYya4kFyKAR4LGchBBQuqRLLg0YOJKT2
 XtX1h4L1ySqPmqFmzLAkdvfbCbWw8U15jeu/B0n/Xn1v+dZceOEiHUpwtupPT18kruh9N9Gyst
 X4AeksKj84AAAA=
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
base-commit: b00d6864a4c948529dc6ddd2df76bf175bf27c63
change-id: 20250523-qpic-snand-avoid-mem-corruption-301afabeb0eb

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


