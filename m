Return-Path: <linux-spi+bounces-4998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADA987589
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 16:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B851C25431
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352D14D71D;
	Thu, 26 Sep 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBFTpZkE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD65136347;
	Thu, 26 Sep 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360711; cv=none; b=ReJRIkOlVX83a7DFN3QeH1Xuwe4yYdRFTEdx3k5f+K55BbQj6UQlwFnTH4Hpo/lE5zlIHs1AVVaPIEWUtTRZD5/HIsu83JfHa+cAhM/bRJFiIt4Kuq4iYGWB2yUbTU4JEKgjstwFJHg7sm2VXpdnqzQokvqTVFbk5rg8sxtVZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360711; c=relaxed/simple;
	bh=5JftokXEaHEI6hrKzjQMAvsOf4Srf9dHkcA23D0htKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djMihqkVQ7frmyqon8WJJ+bpCAdwfaYrZ+tJiS9qA3Xqt0L7DzAIrSuAwD5dM/basj6U4z4bQDceT/ddSR1OKKyNSCrMednDlnXzz5dpZH43/8PU616mUDrIWEbiLKjKpUC3SMyIY1SCBsuYoHlxI2+Pj6RPVXOMui9oHyl2VsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBFTpZkE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206e614953aso11431505ad.1;
        Thu, 26 Sep 2024 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360710; x=1727965510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDfixlWfB11NTzG+DiZcp+HxxNjjLl7YE7F3FyH5220=;
        b=MBFTpZkEzxbSMry0ZJ2PfgoYkhCFi4OOrwPlXSHoaOSVEkAkBiLKjd9B3WzNtI5cfk
         XXBht+OZ6XRGeb79u15gs5IgEhKvh2RRrHDQu/ME53IHq9XoswlLTR2nJWTZBc/gznba
         PT5A78L7N8hjSrOfeaNAfhgFWQHccknoik801MoEXERMEWnLFqTu6C5Yv11NExg7BLu0
         R38+6OFhXfXwvLgGK+6ATiy1Ls/xNWUHrXqvd1jsqUP1CJvsOTXnJNe3uq1STZMF+YDr
         Zg+/+IZqtaRq3UsLvZhyFLVz7LmEYrc3KDClU4kR+POPXMxNhVxFP7ouBFij4Zt/kJkI
         sM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360710; x=1727965510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDfixlWfB11NTzG+DiZcp+HxxNjjLl7YE7F3FyH5220=;
        b=Ae6+wSaUwn4WFKJ/XtllwMgUOdC8c3GOv7KSQYHGccX8jGOHL3lfPOq6zio475yrzC
         c2pUT54BRdrRfA1FjDJnTIQRb8EIzP9S1NHpPSGeKSvVIuZUXfAv3k/IZUzAR4Uzql6a
         /2DZMKUIkoYGge5awvp/ndsTvveiqUVqIPG2VYiG/XrJeG5P81d8OpLwIqrvymBgfCjj
         Dh9vPoXzpej+P5u0zOK/9UMIXfX7lWDmexGs+mm1+qzsTcenVZ34UgbvfOqudUTC2mIB
         q65VqqbHcwFZprgX8CIWlQ2boxFn8PaQ617huhKrvkgN/ITdJrIVFVqfyGTegMD9Y428
         tk/w==
X-Forwarded-Encrypted: i=1; AJvYcCUtQjBPHKE1bLm62rU9YFUwOH5qD9TB7aP0XD5+t2QDqO/Xt19X8hYNUXl9cBVOvoiQ3K+32HrQ4UVdNDQ=@vger.kernel.org, AJvYcCXe4Zuy2quQ7SUwjHHuaeguPG9a3/e5hpcrpGA2G61TFmx/bT3nYspsjcvMUYcgyxWbcvQPA0IQ/nNb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9KEThvxtpy/chK4MXroOs6C1vZgnb+ix4nKdHCKJghtFRFdiy
	OhH9TbeTDuCPauPQl3/X2F8pf2MTOhq85vMC3cknMaAeQBU0Slc8He/tfA==
X-Google-Smtp-Source: AGHT+IE333dRtcjB/bH25gT70pEVLd2X2WNyQw8Cm5nP+frUF66NPd8Bf0+H2KFZjKoSYqFWdRqr2A==
X-Received: by 2002:a17:903:2a85:b0:206:8acc:8871 with SMTP id d9443c01a7336-20afc4b98b8mr84561385ad.31.1727360709537;
        Thu, 26 Sep 2024 07:25:09 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b25059b5bsm10130265ad.155.2024.09.26.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:25:09 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 5A1AB802C9;
	Thu, 26 Sep 2024 22:32:57 +0800 (CST)
From: AlvinZhou <alvinzhou.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	AlvinZhou <alvinzhou@mxic.com.tw>
Subject: [PATCH v10 0/6] Add octal DTR support for Macronix flash
Date: Thu, 26 Sep 2024 22:19:50 +0800
Message-Id: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlvinZhou <alvinzhou@mxic.com.tw>

Add method for Macronix Octal DTR Enable/Disable.
Merge Tudor's patch "Allow specifying the byte order in DTR mode"

v10:
* Further explanation on adding Macronix manufacturer ID in ID table.
* Correct some typos.

v9:
* Change the name of the configuration register 2 for Macronix Octal 
  flash.
* Fix the bit value in __pad of struct spi_mem_op.
* Use the local variable proto instead of nor->read_proto.

v8:
* Supplement missing S-o-b
* Remove function spi_nor_is_octal_dtr_swab16
* Split IDs by MX25 & MX66
* Add dump of capability in debugfs
* Add dump of parameters in debugfs
* Add dump of result for mtd-utils tests
* Add SNOR_ID(0xC2) in last of Macronix ID table

v7:
* Add dtr_swab16 judgement to enable/disable Macronix xSPI host
  controller swap byte feature.

v6:
* Add byte swap support for spi-mxic.c
* Remove flash name in ID table.

v5:
* Remove manufacturer read id function.
* For increased readability, separate Flash IDs based on whether
  it supports RWW feature.

v4:
* Add patch for adding manufacturer read id function.
  remove patch "hook manufacturer by checking first byte id" 

v3:
* Add patch for hook manufacturer by comparing ID 1st byte.
* Add patches for specifying the byte order in DTR mode by merging
  Tudor's patch.

v2:
* Following exsiting rules to re-create Macronix specify Octal DTR 
  method.
* change signature to jaimeliao@mxic.com.tw
* Clear sector size information in flash INFO.

AlvinZhou (6):
  mtd: spi-nor: add Octal DTR support for Macronix flash
  spi: spi-mem: Allow specifying the byte order in Octal DTR mode
  mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
  mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
  spi: mxic: Add support for swapping byte
  mtd: spi-nor: add support for Macronix Octal flash

 drivers/mtd/spi-nor/core.c     |  4 ++
 drivers/mtd/spi-nor/core.h     |  1 +
 drivers/mtd/spi-nor/macronix.c | 95 +++++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/sfdp.c     |  4 ++
 drivers/mtd/spi-nor/sfdp.h     |  1 +
 drivers/spi/spi-mem.c          |  3 ++
 drivers/spi/spi-mxic.c         | 17 ++++--
 include/linux/spi/spi-mem.h    |  8 ++-
 8 files changed, 127 insertions(+), 6 deletions(-)

-- 
2.25.1


