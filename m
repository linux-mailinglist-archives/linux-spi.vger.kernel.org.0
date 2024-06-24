Return-Path: <linux-spi+bounces-3565-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C789191583A
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 22:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F54B20CA3
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1691A08BF;
	Mon, 24 Jun 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n6qn97SK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3F49650
	for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261996; cv=none; b=q//x69XVAR5lmR2rZug8NmTE2yhiQNMnsixGA/A4hyCdIvE5lDx+R/1zTGU+Zl10ycleRg8ZbR20RHAxvmKXj5ZSLl5CdXrVJHGKmNksO3bXawv1I/ZHBf2FovTHC7M3Knf+blcUfc2CN0oGaAr/l06VTYwUbyubT//v7PYILvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261996; c=relaxed/simple;
	bh=upztjv25Pksc3Dz/iEL/7RhD28y3vLRW3nFh17Sqo3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqG9fBaa4uI6+c+dNN1nEUKbw4E3MmZdbZIoRlGoPkS/fKLBNUj9aJ3CqxMnxCUWuruiMM7YSMyJ0Vwa95ZN1qiwg5j6ZV5atAEITeLXpEgJ4vK/cX+bUkJ/aMDRNyeIGAnwLt/+SGZNez1pASWtz0/i/usF+0ZdTJ1scVxLIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n6qn97SK; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25ce281cf3cso1440535fac.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719261993; x=1719866793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSBK3Ki9ZCk+SLUNlkl3PuQfRvemuJmKwUzbo0kI5l0=;
        b=n6qn97SKTihk2e7+h5ujpxfMJqsR5ZZVt04xjmnotua/Bn1POAKVOqw2dhQxeXMAfI
         xEDo1ZAt5DKD3VUIKfrfO1FWDEqSHfwRNmc8xSy6W8ZwE0BClqJMYTg+HKrDO2KQiyCR
         jbkM9CvxDC0GvMX7AGuCQvrR9XBmt8kkUfUtLxI7OA0DRWSaWen45gQTe7dJmV8U6RLe
         2VoQP5A/j3kb8I4N7WlHinuWzTvPaTLUt1Eu07UBgj2+PamCbFU/TwPDHvkyc4IIbTCJ
         SPpqQWL3jSt4VBPS+wLDTvrB8dqvv0bXZp7Lh11pzXx084jb8z/EdWzkRP8HVrdJ9TVK
         T4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261993; x=1719866793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSBK3Ki9ZCk+SLUNlkl3PuQfRvemuJmKwUzbo0kI5l0=;
        b=mC5Z67aPmoBXEoUt1bnSHOglncvxiUVYc+erF8q+I6cYYJNWb4pva5DPWk0oqkk6uo
         Q88IKO+KXURramvvh/qeU4RFGmHzEAqom5jPZaTUKeqMqtboRQA9+xLUVRylzy2XidAt
         /tOHpuJQ/KjebBklcT16ixWut1dEBPdBnYzyMSZ4OpaQv52HO79P+pcA81t+6raXxyAt
         6RZXzisKWW1C/efOOSS2wtOo8jbDbMtvYyFASOM+ANQmOga14m97JkQgdWsvAqxRu54Q
         lZzCL3vE8mDze7j8Rf83WMBABYnhwVG/OKurw5oKGTW4pK7MGBo4AMX2EauHTyMj9Mfi
         ENtw==
X-Forwarded-Encrypted: i=1; AJvYcCUU4dnZROEhbI0D6mBe75//v+qhiaFPcXqFiYizGF26H33PhMiDLMIjgZF4YZk8PTnD1aGXR0d1U26DZoJhpt8VHCQ0Fj8eToVH
X-Gm-Message-State: AOJu0Yx6BG+QJd8DsJrf/HDexFSe/Haus/ACCghhpeeSPuZsyHqOTU05
	fXtbFLDPl9CdZxkZDCmBy64vpQ8uhiWJYjO4oHOCNvlI2C+8mYa2nY0GagzHCvg=
X-Google-Smtp-Source: AGHT+IEwgOwFrf9DOHaWD2v90KNE+gUgBapBNCTryATgRwothFHnMrTK/MjIW3m5Lu9aBAxgAfhr3A==
X-Received: by 2002:a05:6870:2d5:b0:259:8321:243b with SMTP id 586e51a60fabf-25d06cc56aemr6137152fac.24.1719261993625;
        Mon, 24 Jun 2024 13:46:33 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c106dbsm2092849fac.58.2024.06.24.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:46:33 -0700 (PDT)
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
Subject: [PATCH v3 1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
Date: Mon, 24 Jun 2024 15:46:07 -0500
Message-ID: <20240624-devm_spi_optimize_message-v3-1-912138c27b66@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
References: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

devm_spi_optimize_message() is a public function and needs
EXPORT_SYMBOL_GPL.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20240624204424.6a91a5e4@jic23-huawei/
Fixes: d4a0055fdc22 ("spi: add devm_spi_optimize_message() helper")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f953504244b..814d66fc9753 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4384,6 +4384,7 @@ int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
 
 	return devm_add_action_or_reset(dev, devm_spi_unoptimize_message, msg);
 }
+EXPORT_SYMBOL_GPL(devm_spi_optimize_message);
 
 /**
  * spi_async - asynchronous SPI transfer

-- 
2.45.2


