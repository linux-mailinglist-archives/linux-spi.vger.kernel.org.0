Return-Path: <linux-spi+bounces-9334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94037B1FA7A
	for <lists+linux-spi@lfdr.de>; Sun, 10 Aug 2025 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191051898122
	for <lists+linux-spi@lfdr.de>; Sun, 10 Aug 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CB26C3B6;
	Sun, 10 Aug 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBVbsK44"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29152265631;
	Sun, 10 Aug 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836761; cv=none; b=D4agQ7BFRUp5zAZ6rWS6c8qubbxvGFIDjX+pgs+QuYEtBt8w8sEJTa2Hh0pMVZtRUydC4wet9TR1ljCIcedZ9B38Lll7eRMjy8vpm92I65zvLnQ6N/xwfdlNX4WSrE4S2mC2oebXvTrHu8akC7JF5qeWNkwdCbW5BUSt5LG1SFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836761; c=relaxed/simple;
	bh=71mo4Lu2FLDx9N5UizH96ZPEgbjHJtCKF5QJxqg3Qbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nxq4h4/kJnP/xAKK2schbfKr2uQlnLPT5JkaGfzGt1czhqBxwPb4knJoCZ+sXAavMbwn/3Vn/A0oQ5pRao6J5QEQjvlW7DPKtynZVaifEQ7+UTk/tdtFnLIqTBj+COhbCYJFL2nybAaXsbNHBDC7gezHwobf9IBZ6a1ZbPKCbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBVbsK44; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so21987455e9.1;
        Sun, 10 Aug 2025 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754836757; x=1755441557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O7vRcMwEFVP7dodHcQ7X4md2K8okfmo/tHy/twqkHg=;
        b=OBVbsK44DPk9nWXfjnjvfLphIcTrEb+sOxa75mNHmN+jmzjWM2m/8pfCJUM7zuSuxe
         c0K5osoKu5l9jD29YeJL2pU458gvrylVHvrQ0khuBcIj74LIYdE2QxBjzhXjkU1oVrGe
         /LXd700oTZIzRoX7381aviGTwr230BM+JksHnSDpYi2o9O2a55kcYLSETjQyYxz1BMKE
         Dk31cGh7bUEZJMUtyZapR/G5I6+MlCwnCfC0TjGv6pMaLxKYYaqM/FIa6W1Q7R4LSzd4
         OULdR+MWlPS700pLtm7C4IX/mH31elnBqlzDE9NKnN77IOVG125BvbaHtHUnht0edyjF
         0XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754836757; x=1755441557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O7vRcMwEFVP7dodHcQ7X4md2K8okfmo/tHy/twqkHg=;
        b=kxwo6rWjmxtbWH+5J76orXdIiwJCbIeo9j8KAPERVJf+EO7qngehqpdVwgqGXL9h4t
         1HBl+Eeo/QjC+GdGRsM/b9vuLme+Epdi6T/ObfXedxrLHySERfjnaAB/XIMgFyL39A0H
         vkGBU7TK+tgc8Z5smEQqfIsrhHb1rlZzL1u+6vrYzcnfq9DmukMObCZcpfFl1PhCltrN
         0fGUDJlatr5FlovMlTtLepNHTux4goH8mt054gecs6EIVc/UnV3Qr3V6sL7ScizT3VuQ
         M+63s+y9ZNSLt/hLnyC4+puAxSQe2htoHzBnTNIE8jEfddWPlFC56IDvHRKvr577JjdC
         Q/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVmGRMf2rdAMf8j0itCnh0hpLOZnKiHwLoARP6aoviv7sd1YQS6SpiHeLKga9qCnT6LaJ0/j2avbLztAI2P@vger.kernel.org, AJvYcCVnK36JCKUUbL1uLg1OG5mtgM71MQxg/XJAC+d2BaHWvaeHPcqzlOkHnHgsFVT2y6UVpgfY5vwCvaxs@vger.kernel.org, AJvYcCXpmOE1wnCto/DvTS962If1dYQx36Ylg430m95wLDI1aJ8VTQgDa2TFq2RYGXaZj5b88PsBkJsyo23qp73x@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SwEp/9UyPs4NvEQFkENik1z0H6HUc35u0aANLG/UxUIwJt+F
	IiBX8kJz6miwDhBQhBratZuJbq234rEwxCpGIDu0jauh5CabeL+Aes0vAtvvVA==
X-Gm-Gg: ASbGncvz6KlzD4xjl6KGa0hr236R5PMG/QhxCGaLcP2Tlxy3M+iUMl1Ry8/2O3GH0+x
	xv2t2X63iNpug0oTiKNt1aZZ9Q/pwsdExzvran5Xyr7T74v0s6u297ydC+RDHvAcGgEzyeWYZom
	AqWcgiGf8iXMtkGShKpc7q2EU0VAVpIJOAl8WDM+G7wPb4SEgiydwLqVnqjIFFz1fs16b5KVxso
	gDTK4SAERJzup/TUYBivNo7zYPAZevNBVXTV+GPVZMMR+0Z+SApAmMyo8byzOzMG2qnHkJA0PjC
	zrqwiirOmK285DQk0uNiOxqmzugJ1Db+sDPkXtR4pC6QhvSS2e+YM/Ai0XYrjec61uljyAgRB5Y
	2tstjfihOLVp43b+qjMgUZ6D4n2QTRlQrW4QJuROJQZWBqJIp1Lo=
X-Google-Smtp-Source: AGHT+IFriHNfRSUY+nrgYqvfc98x7fIebMd0YvKqXJrl8fH85WF3xqxHwfsGbrwLZHbCzjxKoBC2Ng==
X-Received: by 2002:a05:600c:4ed0:b0:456:1bae:5470 with SMTP id 5b1f17b1804b1-459f4eb4126mr90929485e9.8.1754836757121;
        Sun, 10 Aug 2025 07:39:17 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm287721715e9.2.2025.08.10.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 07:39:16 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 10 Aug 2025 16:38:50 +0200
Subject: [PATCH 1/2] spi: spi-qpic-snand: remove unused 'dev' member of
 struct 'qpic_ecc'
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-qpic-snand-qpic_ecc-cleanup-v1-1-33a6b2bcbc67@gmail.com>
References: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
In-Reply-To: <20250810-qpic-snand-qpic_ecc-cleanup-v1-0-33a6b2bcbc67@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The 'dev' member of the 'qpic_ecc' structure is never used in the
code so remove that.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7b76d2c82a5287df13ee6fcebc4abbe58ca861ee..bc2158e560be3b0ab1b26882e4de524ecf662d14 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -78,7 +78,6 @@ struct qcom_ecc_stats {
 };
 
 struct qpic_ecc {
-	struct device *dev;
 	int ecc_bytes_hw;
 	int spare_bytes;
 	int bbm_size;

-- 
2.50.1


