Return-Path: <linux-spi+bounces-1027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9D849AA7
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29080B2576C
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869D1C290;
	Mon,  5 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yMN7E8W/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1F1BC37
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137121; cv=none; b=RwdScQY7b5HXnICgmvdmzch4J3sOlzybfIgYtMNxaJ/ZlWYEABYOwykccwU53aa9fDFtYOKf/EvSIeMWw11MjRwXNRpPdAWbvPiA7qpIv40rHMMNmb3teAfp7TvN6ujg/7rHCimNu91CVD5gnKycY7LPnEANEeWtKEd5EYKxTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137121; c=relaxed/simple;
	bh=bV+lpitM1SVsJG0AnsgTt3rvbBzyLfGeUChqy7K4Sas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ac/mk4e9MM80eR2m5tqde1qC4B6rVPFbrYoSd9zFYwpVMifT0qV+lURahkPYOzxwT0TE5YFl2ys7yu3/9RKoo6VyWlLPqTchPy/QjauoTnM6VdqDWc1aThU4P6TWyf+raGMwDPF9neC7IK2yNwCtcbFFImOPSHNOHBJeP+x1k2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yMN7E8W/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fc65783aeso27050085e9.2
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137117; x=1707741917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzqV0UO0jd/4JdiYuZ+6mTTVkqveZDGGM2rG00rXSTc=;
        b=yMN7E8W/7mwsCLbH2DvVD/YJrFsAfAHEdnCmchRksw2fVy8JWQ0mBpJ+tBQ7MQn8HQ
         JZkKcUsFsMeI102/icXvIC+3I6uZwrEMeacCGqX6p6bVJDONVyHvXlgsIIaShFtVOv0F
         Y2wLoIB230FX5PhgVGhy+lx6MmduKK17WFUYAWkpwl9LxVuCW8h7R+m0Z8sE58E58VWO
         422L1/VZeiA8AMvOvtgSTyiEoUK/VNRW7qIt7J2XvUiliOxqYm3NYStb5H9U5YD4gNJr
         6SITGZKuufFN9hAOyeyUy/aehFSnCeH+qDzlWPbqyhYUaGML039kOHjEFcdJPyDjwiw3
         0GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137117; x=1707741917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzqV0UO0jd/4JdiYuZ+6mTTVkqveZDGGM2rG00rXSTc=;
        b=iuSyQPGpow5J2zken2J68QB1W7n+t0m+oKQyliyKsQpN5C6zOHAVoBu/Gfffy8bOaX
         e6F7F0ZvPqrQGvSV2ibmPJBiiw76+XAEvbdSrRFBSAVfkv6asQtUyYkBGJFmOWqXDdVY
         02hlLf5n7u/uyvV8leDEli8jwFQQydgBu3w8cXj/5mR4qtAscicqcKIyF1HDMXDPgtUu
         VWRUzHyo7yDwOPu/+7zu/ANU2JGYUaOIRP0uzMAAiSPM3oIaK9RPFTrqynP3E8xTEitU
         TdOLKEOUyVhwRdQQ0hgL2QvcojPYTUryVji7RR0FRL22QXNzuZfWYC/sknkt0BseziI8
         k0Ww==
X-Gm-Message-State: AOJu0YzJ784c3OCmuAx4fLmAWjTF/YKxMx01pzffPQSo25RkR5Gr+UME
	qNANuzvLFCkVEEwHWbYGZQSSVeqgLsup18bICycULDK2/HPQVwDiVBEnqUCLk3Y=
X-Google-Smtp-Source: AGHT+IFCKz6TaNf8Wi48wX9ZlwyutWIPPZTXx6ugbsIO8/uoZ5HED/9gWjMV/RRvT6DovAc3pjtzqg==
X-Received: by 2002:a05:600c:2604:b0:40f:cb0d:a44e with SMTP id h4-20020a05600c260400b0040fcb0da44emr4478868wma.9.1707137117361;
        Mon, 05 Feb 2024 04:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU409RMIzEsIUgcbbgdl7NZb9Og7FkKHQI6vdbmd+4XwjonGIBFjxdzOKAfbWMz7L6UZaR+he/YIyYAh3Fo/NXaoD14EoJof1rM4EjMBs4R+0EEJlKAVyL5JJkNilcHQJZ7yfLgXGblXcrnNlWnlf9BqDFBbLxFfbxi5NOrrpPXroJgGttBQexJdnNltM/8FvjnoHfUhtiAlkL3nmVTzVN2KxJBiU1mi82BaeyWjP+0wYyacGbQrdTWjCxkSUSyx1nT3JyfjOoaq5locTcXLd+jucD5B524WT1VRAJ1Q1uflMdHqhlgfXry1NVfiiQcaMJpt+WKxwYN8jP3xo1dfUbH+Y2EkprHbnBHInyVjMWFfJ7/5r5q98nl6tTky24pZkY5+9kl8OHY+7YwUPMyGQK1D8A+4n12qP4mI3wjE5+4bXrIR5YH2y+VIx1UtqckmH7fN+WsSpZ89FSYf6fPj9cWw0FOYJgBDq75Uaq4ZrXS/J9AGkRsOxExq/lCuw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:16 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 00/16] spi: s3c64xx: straightforward cleanup
Date: Mon,  5 Feb 2024 12:44:57 +0000
Message-ID: <20240205124513.447875-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple, straightforward patches that were compiled tested.

v4:
- drop "spi: s3c64xx: use bitfield access macros" patch as there was
  no agreement on how the reg fields should be handled.
- don't change the style in s3c64xx_spi_dt_match(), drop just the
  unneeded casts
- collect Sam's R-b  tags

v3:
- reworked the bitfied access macros patch so that the bit operations
  are the same as before the patch. Fix S3C64XX_SPI_PSR_MASK value,
  drop S3C64XX_SPI_CS_NSC_CNT_MASK.
- add a new patches to explicitly remove a duplicated definition and to
  drop a superfluous bitwise NOT operation.
- collect R-b tags

v2:
https://lore.kernel.org/linux-arm-kernel/36a664b1-666d-4fc4-90d9-35b42e56973d@linaro.org/

Tudor Ambarus (16):
  spi: s3c64xx: explicitly include <linux/io.h>
  spi: s3c64xx: explicitly include <linux/bits.h>
  spi: s3c64xx: avoid possible negative array index
  spi: s3c64xx: fix typo, s/configuartion/configuration
  spi: s3c64xx: sort headers alphabetically
  spi: s3c64xx: remove unneeded (void *) casts in of_match_table
  spi: s3c64xx: remove else after return
  spi: s3c64xx: move common code outside if else
  spi: s3c64xx: check return code of dmaengine_slave_config()
  spi: s3c64xx: propagate the dma_submit_error() error code
  spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
  spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
  spi: s3c64xx: drop blank line between declarations
  spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
  spi: s3c64xx: remove duplicated definition
  spi: s3c64xx: drop a superfluous bitwise NOT operation

 drivers/spi/spi-s3c64xx.c | 80 +++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


