Return-Path: <linux-spi+bounces-11439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB613C76590
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 22:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAB36349981
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3A302172;
	Thu, 20 Nov 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="f36IRgW6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33550253958
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673228; cv=none; b=CzZIwouZjT3TBtreMEsyzVjA5iUF9cA2GsdzzI7Rvitt/Fq8RThZFuGRI+cqxSQGh5C56y+ZhubauewRTRipINLsNnBdyEo6hs0kQs//45u/OPy3pBMQt1ZMOv9S/pGIgEh+JYqyN2PUIaC6KW+HhvH+Ot4AA00Y6+ndbJqfX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673228; c=relaxed/simple;
	bh=YZ2upJZ3vV7ruugoQiRqIa0FJdfYNIuxZcSi12AKy1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXx3k9lPOv2Xghi6ho4se+Mt1ONAyciw5la88AgyZtgsDyAZ5RWKV6JsWb7W5uYQ+P8yVnTvRuA+jxVUMSATDqvry2g4vInfY+oWCu3mnjeM602idcdLz/dU596G2fIss+VP6PFu5x67XXEgkB5iILeG/rQl4IsvttfI9kXm8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=f36IRgW6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so9690161cf.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1763673226; x=1764278026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNS/Y+KcMoFHGp9tjvFZ7eEQqbVr5oOBNTZAWfcwrAw=;
        b=f36IRgW6vvtmNDNYug6jK+P8kRBN2ZdXRm2OHC6biGuWzeBzcWuJ0UCKJO5g8CR8Hz
         /FAno76Juv+lJu19dV1UZwRwS3cRVCSujTJottutSaitmN1qV4e/niOuSE714fASx4wc
         zz/HsX5Rv4NaxMaWsj55CqIMEL43ElLNooCbu7+0T7P2ZQvRflL/XX7vD1W21kWFfL/H
         yV7RM6XgyQmXLPDTnBuHgvOaMHMpOBvbZXitPh7tQUYoMVMOg+8NKwq5ZTNej355z13Y
         4/qLQroXUGjKRIzGT0FzG20cqUw7BM0n+CjqCPzdHM1WO5MeUYFW0JStim5DcMF3FKwM
         dM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673226; x=1764278026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNS/Y+KcMoFHGp9tjvFZ7eEQqbVr5oOBNTZAWfcwrAw=;
        b=llWXeckPwVZEC5nhHismfAoa9aItPWHUGloAQD2tsrwVoHsK2O/G2OQkZjP7kYEIzJ
         NW4XpXQSXdjWq4aI5oQ043la5pgL3BE1BMVSWHIiEppDg6Uy905rfnyCQ5SGX8t/rGOi
         J/ppIHp1wYGxQCRvcv5f2pudPXhfrggtaZ9GbUwv/Yt2wJrC1iyGMIQfFkwcXVcqJjyo
         DLRXtuL5gWFNmc0qGHyZEXxMJlin81+Iwuf+D+9/pIA4Bk2JDDSOoKUkY2TB4XhRaT99
         56qnLxFNb+BzNPputgXLPzk+6IGuAZ3pz7y7jZklROUwZrifPwK/aP2nhn4xRRZe1Maz
         S6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIeIAFSt/l0Heyyca1rAqgRgJnMXPCc0LwMmoLZFRHPqsIAod2RE7tYohWQAfM11mwo+fPouzt/mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmaHjW3ClxH9uuk5gvlQrE8s7yrG+FHrRLLSInpqG1EyNzVDWE
	eVaxVgFpwzmZFBjWUO9pPCnKI23itstScvSixXNSDAWo+TpE6I07YG/mcpzA4te7HFU=
X-Gm-Gg: ASbGncvnZJV8XXRSqnUYbiXDzRgySb4VyPlX8YYVQlqbL5XTdW4loGY336Mojds67CZ
	QSl7zqLWFNP4SujSVhiEuVe310Br+XAYcsE+E6vsWDevbKRfTB4vNWVG9VQ6MJvOlpnbBUwZpT1
	nUKSPxmYyVazCW8+mK4VmRl4SIc2K90SJkg4CeQwRdxcqOIJ/vFS1aq0hpj4WInOO3ZVdsVOLp2
	WEBKzDcfXXZEU6mGonYaoNOmlcVMmQLubyW4w+z2puLePl0wnaRNCvXq66Oz1vPbNwxMoLIDSPh
	+SB/QqgyrvI1qlprHmqGUWNcMHN5rFxskEVfiTkK+pxg+glsR+ENqShZLKhykWg7+txg9d3/v2x
	T//W9O+XMRmkJL+viHaFBb26/H62C1kz0HngwHvy24d2gOMG6TcY+nli17tau/nZnHsJ2uAuz9D
	inoJlvX8KYKPdxpq/Z33CRGuZ9nDzt3lG5nt8AAldbPLX3B3Z0euqrDAQcxwDJVu7YmA==
X-Google-Smtp-Source: AGHT+IEL97NYNDWn+/3PU3JMG6J+CUTsgaqRtGV65OIgCX4XftURpHcWH9smypQCv8kNKzzvRrh4rQ==
X-Received: by 2002:a05:622a:cf:b0:4ee:1ec9:f947 with SMTP id d75a77b69052e-4ee58836b1emr1046891cf.3.1763673225917;
        Thu, 20 Nov 2025 13:13:45 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm225958685a.24.2025.11.20.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:13:45 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] spi-geni-qcom: don't set max clock in setup_fifo_params
Date: Thu, 20 Nov 2025 16:11:59 -0500
Message-ID: <20251120211204.24078-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120211204.24078-1-jonathan@marek.ca>
References: <20251120211204.24078-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_se_xfer() already sets the correct clock (xfer->speed_hz). Setting
the clock to max_speed_hz here makes the driver change the clock rate
between speed_hz and max_speed_hz for every message (if not equal),
slowing it down significantly.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index ed80f49c7b2f3..c33d79d9afaf8 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -379,7 +379,7 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 		mas->last_mode = spi_slv->mode;
 	}
 
-	return geni_spi_set_clock_and_bw(mas, spi_slv->max_speed_hz);
+	return 0;
 }
 
 static void
-- 
2.51.0


