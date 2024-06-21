Return-Path: <linux-spi+bounces-3532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58C912EDE
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 22:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62031F23418
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6217C201;
	Fri, 21 Jun 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O5GPFEHW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1917B430
	for <linux-spi@vger.kernel.org>; Fri, 21 Jun 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003101; cv=none; b=JFGTd0YtkLFKHoB8MZpvh+RXJZZV0P5lQ1IEeWzHUMxJy+K8apdJGalMHYqzmd6ZWRmu+1Cjo5OiFr0W6OimgIPiYCfGLEFYrDMVwoTxuWa03x+u0DpecQifBFML6Riza+DsbEUx7O1OdSU6tf3+3H07BVh2dAgf8iDEyWpUEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003101; c=relaxed/simple;
	bh=3hdGVUorPp9c3chARv02ErSOyGivV5Bdav1bowW+7Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwFiQp2jl/U2nklo4+g/PU9/hj1uDq2cXAdrGEsYWIDJYhtJCClbJfvK0/vHZ374HPVWZ2K5rutofUS8OIk1q+yOU63+xvG1nK1DCmJ7MtTihpEDHcIK1upZWw1Fk9HxP1Se6eJKfTMKYlLldLGTKweMDTzjKmCAQ55uznTQFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O5GPFEHW; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d24724514eso1420842b6e.0
        for <linux-spi@vger.kernel.org>; Fri, 21 Jun 2024 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719003097; x=1719607897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoA9hZ9WnRsqQql+yaAmrG9puGVAmGMo+xjRJ7s2mms=;
        b=O5GPFEHWhsU8kp+qt4EqDMRx0jr13fg65+28kdOFYTnFi0t2mDgDGGgB+O97YzOcKh
         8/k7xrWaKvkVKm75MU+fEBYH84C0njb3QIa1z6oCLWalem9mAyQVo9c3DcliG/XxcJY9
         uMSP8aa0Ij9gOqebKxdYt2X+WcSxptWGAwcFi1fkKIZHc1P++shNC9krSM/Gfbxrwdy8
         5IgYD2S7qyb4qHO36DII/IsiQt9e1qJHQc47tWz5Vllw6jEyOiO8r/TsH8Y+sZLqeijK
         WCTxc0gIAu3YKHsjWr4rg4jykGLp2culo8hniNvQA/44gzNb8RS958LgHI13BJudtRy2
         Fq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003097; x=1719607897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoA9hZ9WnRsqQql+yaAmrG9puGVAmGMo+xjRJ7s2mms=;
        b=Mh74iQz0mego7CBlVDS2hBqAX3xRCcv/v41/g0e+E3YhsJlWhPggG0ji3YsiAhsY6K
         CistGpEbuspdm6r7gjdaIkxWGmquzplD/595bNxwxsYcfkVg2Hqvg/kLi4MdIgGpPE2z
         6jNxUdtityxsFUpFQgfpSjhtltR+2ctcxD5kQwjarZ6gpRTdB36kXdnAdSW29qNiJENN
         luFK5Kvvav/JYAO3Fg1Ohr+GFrX+kyHMdz83I5UcdMC3eH1KEn+rluuOyh+OMCNIQsjV
         KGVUU0eQqjmQJS/iFbxWdeFDZX3NQ/5SbxS4XUudqkj3r4SQW6Bzz3T+0QJgdvIZjLCF
         FO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/LSYsxdIgJ9ktkPRPwxz9AhmOKmJMKbDEvh2H3m1d4wyl7F8Aw6Q3c0foH17mrV75wOg2pio5SC7MzubuZcyGkvSysQewq0fx
X-Gm-Message-State: AOJu0YxetakCFuxW2LDq8dwFV54YEDI0hotQBjykTPKkpCdtpB+TlPYD
	J101AaL7TOtoeOCV5q8woBgeJ3FuSuovMDdZZM7DYnlWlTphvX6xYDIgb2Ywta0=
X-Google-Smtp-Source: AGHT+IG4xUoDcwuELvZwr6LG9uss5vNKlYqqi2OOZdEWOEtWwrPLCmPvrHot1em53eidvgyCgrkzcw==
X-Received: by 2002:a05:6808:238f:b0:3d2:2a43:1c03 with SMTP id 5614622812f47-3d51b96c6e0mr9705037b6e.9.1719003097507;
        Fri, 21 Jun 2024 13:51:37 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e584dsm428089b6e.55.2024.06.21.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:51:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/3] spi: add devm_spi_optimize_message() helper
Date: Fri, 21 Jun 2024 15:51:29 -0500
Message-ID: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the IIO subsystem, we are finding that it is common to call
spi_optimize_message() during driver probe since the SPI message
doesn't change for the lifetime of the driver. This patch adds a
devm_spi_optimize_message() helper to simplify this common pattern.

---
David Lechner (3):
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper
      iio: adc: ad7944: use devm_spi_optimize_message()

 Documentation/driver-api/driver-model/devres.rst |  3 +++
 drivers/iio/adc/ad7944.c                         | 26 +++--------------------
 drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
 include/linux/spi/spi.h                          |  2 ++
 4 files changed, 35 insertions(+), 23 deletions(-)
---
base-commit: 0ca645ab5b1528666f6662a0e620140355b5aea3
change-id: 20240621-devm_spi_optimize_message-ebbde029dd7a

