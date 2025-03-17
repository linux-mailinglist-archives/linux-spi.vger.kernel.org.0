Return-Path: <linux-spi+bounces-7174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C232A65656
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 16:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D8F17A273
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD80250BEE;
	Mon, 17 Mar 2025 15:44:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F962505B5;
	Mon, 17 Mar 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226271; cv=none; b=sCIxbJTCB5m4TFbkQve8OTr39zSZQIXWn5M6B9cVarn4B7d5RcVedq+XlmYj7UnW98g4FMSjDIpg4HQIGr8imUAQE+NEm9kFjD/03VOHzUOHAHf4bbHas2QvXhAuI3Hc79xChhHO2xCLLdGRbIyPRmtq/sx+KZjPDXwXNW3cguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226271; c=relaxed/simple;
	bh=WyIjFqDA0OchucxTCZDGUZ2QgD0RxUJoq9iXFhWFCNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9zrNuX8Bsb05sriuE8ZmT4marAMVcKAox5fo4kYvhjAU6QNg0Q2RPhrinlzTJvFeWId9d7cf54qwRvDDe82ACjIBSz74QMcw+JaBEKDjAULLBf6dwDNV6d4Zx88p5W2uk+xa9JHPeIFlbLdwuhTffYdyImCfR/PDFFHq/qZQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac298c8fa50so866267166b.1;
        Mon, 17 Mar 2025 08:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226267; x=1742831067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRcg98y2/1oq0RZEVoLNyWmHQX4gLm604iL8gAD8krU=;
        b=NZcRKOWfSOqm7CGZ78yqCYF2cTntQIysbKOC1NVOW7dp9YssdXY4msKw4XGWxYm2J5
         LhFPZWGbdL+xROijdZgYQxp1Ko4DpEB5RvR6KlPPhh0mBc1GgJqYoQUKg0+yzOXT5bdz
         iCE17IORwtICTkNldARkBrTTs9Z8d2ePluO0ub14yOyBijvqKQ2xXv6QTWcDr4/2B0Ry
         9GZNltxa6E5CLfPT+zV6jh2Oed3CWrSMguwgeerZ44+wVJ6BIrlNFgWDuDuwgAP60D17
         ZJft+tCpQGNNDwsN8kks93nRMpR6rfLPrwmj84yLt7RuARL/POTjzWD+M5t6AsolSzrU
         EqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYinfpNng/IVim5RfUp2I+pYBpKMyUtMlcZrAKKyChdF7memMpYmSgqqb8GbUWxr9KrOI7oWLrsgn/@vger.kernel.org, AJvYcCUuf0t3tBDg3ZmhXcX7NpFc3CXqvR07yrVq2JIgiKko8lHhpldS0Yybf/T3HrLtfhIJ/FRq0U02R5WbGv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdclZxH6hnJ5cTU50lKfFDvnnUID9R7UMSws/PIhTPGuFQvRo7
	MzNFUVKjlg0OGzSKC08pEfcmU8pOeyen5W1Jtw8DICZbqSX95VO34i/28A==
X-Gm-Gg: ASbGncs0Er2DShe2LilN7p2cfT4YodCTI3PMQwI7BPkSqhiwbJEx+Vw4dEYbPAIUROR
	MkJs/xf2nItjXb2P0eFMPVmFOix4H1RtZK+mR1KjsKKluWsqI5XS38pTA03odq/OW30x7A/dB2V
	KiFuqBO6wCy4wZ/CUJYOmSWqaZo8Va+tR8fnn6fNLehnrIMQvjQs1uWyAuAe4s2kbIFB7kRu/Bl
	1J5JW3JZ972JVEXE6VJaxVzo+RVQIlm7/V9cqf0ES7O7wt6TfDgXqXycLPBoj4n855aK/QVIJbM
	nTbLnDLdP42fnjcTPAtZk/4I+4ObwR9AmqR98fECHxJAug==
X-Google-Smtp-Source: AGHT+IGqLbl9tzol5xcJL1DfDVzWxoUxYy7s3L3Wp0YjYGnU6jZxgvzHOMioKRcjJjto3DRrI4We7w==
X-Received: by 2002:a17:907:7fa6:b0:abf:7636:3cab with SMTP id a640c23a62f3a-ac3302ef9ccmr1336856666b.29.1742226266664;
        Mon, 17 Mar 2025 08:44:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f1424sm681386266b.71.2025.03.17.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:44:25 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 17 Mar 2025 08:44:03 -0700
Subject: [PATCH 3/3] spi: tegra210-quad: add rate limiting and simplify
 timeout error message
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-tegra-v1-3-78474efc0386@debian.org>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
In-Reply-To: <20250317-tegra-v1-0-78474efc0386@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=leitao@debian.org;
 h=from:subject:message-id; bh=WyIjFqDA0OchucxTCZDGUZ2QgD0RxUJoq9iXFhWFCNo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn2ENTKQMkvIQrh+iXkg6r9au+2udMhyjkmn81o
 CmmsG1MoXeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9hDUwAKCRA1o5Of/Hh3
 bdo9D/0f+uO6luC6Qtl/JwTpaj0+B5upTtHWBf9YPz/ufurSH5jIhqX3uIcxeYCxq9arzsU2pv+
 HU6WPANpZrnNI67LEqDERkut3HSO3a8oVaPJeZYKVY4zc/qwjfUzTTl3tKmQW1glVY/IDIBdUwb
 mn6TwqnyGgWYUeuy10cNmyLVJUCC0oJBwtCNHU0zkUR2vfWv0UCJc29ZEO6aVqWMkvnY39I9nZB
 m5gjPuqQuzRaFQFLRR/aiVOuNBXnm1xj2ZD5GyfbSf6F9rM91xQ+X29Dp4iiBFeSOEiPQKr1jYN
 aDOFfq0adBYgO+mLXrmO6w0FsDqZzaPxRTwMFmCxmfN+ONGh+GDcnhMUe3kVhFX8nTP0IGvonlW
 DV7oxKZJQSkuU6vcPF+isxGiYyjqQcIfCPSAx3rcW3Fh7i6oK6j0mN5HFDixSmMci4wtgSHINjl
 HqPKdKqSVrZI0MzT6u830Jk0j2seabRO2K6gk04An/T++9idksoF9ziDFULEvTwuRuhWZ1YqNoZ
 AFmupizgRyhRrDPifjqAbzuSNjWOWzFzNP2iHlt3HlFjeYnHjDi+yNIatJ1f10UiyYL0nIxPby/
 +0M7XusDie03x55/tYZRXk50kvhEk/1NbbFjTGHlwWKr9xlisapw2+z+Jfe3CJBbnbXJJSzuTdD
 fvVBhyMSf7LxKXw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

On malfunctioning hardware, timeout error messages can appear thousands
of times, creating unnecessary system pressure and log bloat. This patch
makes two improvements:

1. Replace dev_err() with dev_err_ratelimited() to prevent log flooding
   when hardware errors persist
2. Remove the redundant timeout value parameter from the error message,
   as 'ret' is always zero in this error path

These changes reduce logging overhead while maintaining necessary error
reporting for debugging purposes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 7c10b1272b0ad..e8dd1c061a49b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1118,8 +1118,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					QSPI_DMA_TIMEOUT);
 
 			if (WARN_ON_ONCE(ret == 0)) {
-				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
-					ret);
+				dev_err_ratelimited(tqspi->dev,
+						    "QSPI Transfer failed with timeout\n");
 				if (tqspi->is_curr_dma_xfer &&
 				    (tqspi->cur_direction & DATA_DIR_TX))
 					dmaengine_terminate_all

-- 
2.47.1


