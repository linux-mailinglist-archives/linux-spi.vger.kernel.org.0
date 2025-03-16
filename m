Return-Path: <linux-spi+bounces-7157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92CA6342B
	for <lists+linux-spi@lfdr.de>; Sun, 16 Mar 2025 06:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28A77A8011
	for <lists+linux-spi@lfdr.de>; Sun, 16 Mar 2025 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334EB1531E8;
	Sun, 16 Mar 2025 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9q2Dv5C"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12D224D7;
	Sun, 16 Mar 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742104049; cv=none; b=beE1+UNwk4vtwUWUaIhzUyvQG0gQxHe9XiSIp9FjmZ6kj9AKsrwAcHGKCSBjZrKJdATtWA4KfVTrsAA8rCnsq2Acrthg0AknYTmV9WKV0+1nJKR+p77y0DSM9f7r9PXux5R/ypFV6MVCbrHMzHNP3l9+2Sq6PV4OWsAFsJwUUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742104049; c=relaxed/simple;
	bh=R9WyEag2fAaVXiqd8h54TmccUs60zbahWxAdfBqPXOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqW5J6CSY27xlW3Eim3zVIHvAg9zKyNm7FVwFk5aMVBnM0nIWOORaUvEPia0UXUved91dAuaRZEHqG38vN/gPmnzEVhYPLHq4UBRi/KNOHQLH4nXhQID8cwrmIu7H0IpqNyqa4lFuIfHPH/i6GDxGjGa1/1on27q78WwZ5MnF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9q2Dv5C; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-601e049d92dso1592957eaf.3;
        Sat, 15 Mar 2025 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742104046; x=1742708846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnS2hA1QVsIRAdP98on27uAAcMA+rniLvABdXS/dMUQ=;
        b=J9q2Dv5ChPGKtATUPW9dqUuvBKYCHFthiSHJ8//r9IcUglf+nfj7IbIMqIDokxVvKQ
         Tri4yUfffCzxSu+NCzLOFHzpjipiHzIXC2/nfIKpirTmliRlZCclu/pG0p6rwWXaWZHi
         ShHXoxQhNb5B9KGDpVohqRYYov478H4K++FNMxhArsvo30pqWpCrM2w0DA+ayVHRv9jl
         U2YQokLLmKqRalLy1YZHwp0l+aRz6BKupkRb/4NpsLLmnsdrbqQQPed5nu0IyH99wVHE
         q6dPtty3chMkDAiJPImkJnWw7yc+gs+mBvC0UulyddNxvX9upYsxojx11X6euTt5MD9T
         7V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742104046; x=1742708846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnS2hA1QVsIRAdP98on27uAAcMA+rniLvABdXS/dMUQ=;
        b=F1qkWa2JxKJvqsUSop+HkU2u/EtZw5dSanW9Q4zrK1bHGgEClp9lSZ9DH7lEpd0k1A
         nbRWb5wwXwn9IPSC3/Uv9JUiyN0kUrsQWApoP3jTOqQpQ7ZOkQ6xq0IReF4Poo/db73z
         7GEoY4da41jJXJrrZs4xw97tG3mVaHdlSsRRLg3x7egEKpjxZ9NRigzfzIC3wUpzOybk
         BNO9h4JS/egqrXbW1OBD8KyVMB9LvnAgsMil/1qSaoZ0T/YNPJ8/i9tQsGUQZP77ksvH
         Z4n7fENlNbor4CZSgTj/0MSpMYy73PbwOoF+WoXtrZ7DmXA51+Lj/oo9gK7FCcB3BRb4
         gsNg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+XtmyZAsdlsbFQTCdU8exsHCu+GOlg8BIHQAygNVd3RC+fET7MTFPMuePrBikbcbgj6V1cenXiRQ93o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WNwQCvlMUJ53iahIIFCMFVWsM7qACeIwbx6xGUvGfsH1NE9/
	anEpok5pnWvwz407FH/eqpvqdphXhZd4N1cAptpelrPjPv7Yv029
X-Gm-Gg: ASbGncvZ47RD/CIjXDMYEGBmda8emNk3reNkaRyXi4U/M3KdYXTYjfPqxTH5bNjmLRV
	Ur19Z0VGc6QTjFwwsYEKzvWrPARjLizy7YhXBQMj1JIbnm5lucV8DB8A7n723wBG+vpWnb043hy
	YR7iv+EBKooqe0ShS3qfZUycDHjVZwuNGQ+t8qOHBilj0WkahhYA/fIrV0HfRyx/F5OY+Veam36
	5n/2N/6UaUgnIzPwFTNe8zdQme3bjBudZtigH966pA+2a5vqB7MBeVunTxZOoNmQ++HpD+Gz98r
	nlzI+yd3VfnbF951bShsaMkiJSkG0fHoeAluZQZ13r1Cv3uwlmjEuHza+Q==
X-Google-Smtp-Source: AGHT+IF1ahK4c+PQGcBeLFIQnE/pV/CUYE+MbmGfFxq8K4vTdYU7igxqAGQA9aBBMlLxdj++y0uRYA==
X-Received: by 2002:a05:6820:1e11:b0:601:a677:d126 with SMTP id 006d021491bc7-601e45692bcmr4018566eaf.2.1742104046602;
        Sat, 15 Mar 2025 22:47:26 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:ab45:2491:585a:53b7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db7a240dsm1211347eaf.30.2025.03.15.22.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 22:47:26 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergio Perez Gonzalez <sperezglz@gmail.com>
Subject: [PATCH v2] spi: spi-mux: Fix coverity issue, unchecked return value
Date: Sat, 15 Mar 2025 23:46:06 -0600
Message-ID: <20250316054651.13242-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of spi_setup() is not captured within
spi_mux_select() and it is assumed to be always success.

CID: 1638374

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
v2: Return spi_setup() directly instead of using ret variable.

---
 drivers/spi/spi-mux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index c02c4204442f..0eb35c4e3987 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,9 +68,7 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	spi_setup(priv->spi);
-
-	return 0;
+	return spi_setup(priv->spi);
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.43.0


