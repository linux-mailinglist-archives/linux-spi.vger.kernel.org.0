Return-Path: <linux-spi+bounces-7153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52658A62642
	for <lists+linux-spi@lfdr.de>; Sat, 15 Mar 2025 06:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6FD17F443
	for <lists+linux-spi@lfdr.de>; Sat, 15 Mar 2025 05:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC54D531;
	Sat, 15 Mar 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK4QFioK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64725228;
	Sat, 15 Mar 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742014861; cv=none; b=apwNRe9tF/Ycf4TvbKa/1IaMMUWXetvS1ASvGeg6wjeHa3V1tyCOZqrBCFONXFgW+XDkeDjIWtWaf8OpoH7n+RM89DTMuKbkf2fFj6QGoid4dVgNj3a0PbGKwSryogvMKfeurXp7N/QIELxnw4hM4ChWg2BlF+mCgDMsvVHfv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742014861; c=relaxed/simple;
	bh=ufCbX4wDhYfEKmDJ7X2B/vgP/oog7w8CSCvAEkWvnr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlpoL7fJI8hvr7tIjX3mg9daSqvNVjqDCTeRtjg3BHsnsKWB+9N8BDHiLpJU/hDlvTSgKi96+lFkR0IPUuNcnGcZGIzdsmEWzdwwok/jSwv09BU3CsM4wSrpvowTC3GMB2poxTMZ8wsfJof3+ILFqS/F2M17Va6rY0qbBjrj/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK4QFioK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fe9c1c14baso1570644eaf.0;
        Fri, 14 Mar 2025 22:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742014859; x=1742619659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7a5ZrbTklH/cZhoNtA/q7i5fBAs3LP0PvXI1WH8nm0=;
        b=fK4QFioKN/W4ucd67Unzvr5qAnLDIwOChGuF78ilN+UXHT/VzXtYZCUaOQEcSiUoe6
         WWyvigSnCYhSXZYWZK0kUpBs63oJ/rqBCuGipP1M6SvOXmkhXxfowja2/nL5kVHMoUqg
         W9sdjDqqtONvSIUuPjTloQ/gUdGW4FGNEYlnghREMIiIoRy5yofX85z/GVn+peIT9Cm3
         vSfajPi5qyabOemfZe4BkpLd8pU5R8cBMXY/qWKU6YncnQR/nrZldCk3sJqY5iFAnCcz
         BuvJL1FmM+a9/IoIt4jHyQFvw4n8/YhHcu8uLncWOiFlx+ZGJcZHizDtrETZBY1tk5fA
         l2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742014859; x=1742619659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7a5ZrbTklH/cZhoNtA/q7i5fBAs3LP0PvXI1WH8nm0=;
        b=G61fH8PQpfcMy4ufbqlO3um0obyoqevG1XkqClO+cRjilW2LKW3euoc4JEFtLvCElo
         jGltWjHHV5SUP0RJDKY6hwT10gBz87QUwfNeHwq4N/QVUBcc/Z+bi+mgTvRkmtOpPG8l
         VEU62yj6L3YrTtFmRR+d7UQqkjjTlSVJ1Y8R/H7+ufpvXrP7i6M2e7/xwl3dsE541z1a
         HTz2V9418KwnG1IkEgqw3W82TjJjEX8TbzC6Uqun6zYEvKrPwJWnuRPxJeddykEOvJV/
         3eU6IjIoha+qdEjdVtlsqerjgg/JDl0Z3ZjQoMU9xvNjSFAEioEGvXEf+atLDOuDVSSB
         mslg==
X-Forwarded-Encrypted: i=1; AJvYcCXTXbJlupQcuHlxImZeHn4qHwqqQ+6gpuMKWCFEMifaQvY79oKXf4dsZOmn2Xgy3HKM71ija0TmY896aPg=@vger.kernel.org, AJvYcCXaPHvdWVV3LVkjT6bFRnYY/RVFJAW+uiJuhAT0ZOOeSiPXx0EncL8IfKIno5wTdXMCT344XLukU/bW@vger.kernel.org
X-Gm-Message-State: AOJu0YzYB3ASbrDdeX2wOzfKaqtNi5b3QZqS4k0xRdC8nfsXj7F6+tB0
	9y5EA/Se9uRVfFv/KbCpGM7YZqbGyEpMv+AZCAP71Peq+vqFrKTN
X-Gm-Gg: ASbGncsQqqc2ZYgdHb7S46EuWo7A73qF/0Cf+fgfZZ99Apax9Y1wancawIqGybFhpKN
	CQ/ZZQHb3jNSvbWIFZLOCqWjoXkhm5aLudiWEmUMqIoKFxnthE12Yo9HOSAdwEyQngYCV/uSN0d
	muD3ISKZ7F8LLD4mW9ZbY9QVHBq/uYGbuPuUJ1HdR/IX24RQNfAPrT+tWBfiBSmS0/xuzCweTvk
	JvAuLfMKg98tWVGzloYh7EKjIMp8Uq3A5iwsVSdad3sqrhV6OycO5Jvb23kwmEBKeIS0d6FGMxN
	6mC1k4wgmNeedAFXOYKlDZRm23odWzGPuidC3ai+rUxKaw==
X-Google-Smtp-Source: AGHT+IG8gQM5ZIlrT1QhC0UHYeZZ8AHDFWhL8amMXKDr5ttcSgilM0pTiFSBppMBAYCbtT0hRryC7w==
X-Received: by 2002:a05:6820:2781:b0:601:a5d8:6a9e with SMTP id 006d021491bc7-601e44835e3mr2316066eaf.0.1742014858690;
        Fri, 14 Mar 2025 22:00:58 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:e7c:e504:c0b1:f8be])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db6598aesm869578eaf.5.2025.03.14.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 22:00:58 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-mux: Fix coverity issue, unchecked return value
Date: Fri, 14 Mar 2025 22:59:22 -0600
Message-ID: <20250315045936.27421-1-sperezglz@gmail.com>
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
 drivers/spi/spi-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index c02c4204442f..0f45a88bfbe7 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,9 +68,9 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	spi_setup(priv->spi);
+	ret = spi_setup(priv->spi);
 
-	return 0;
+	return ret;
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.43.0


