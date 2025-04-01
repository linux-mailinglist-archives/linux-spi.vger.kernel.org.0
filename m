Return-Path: <linux-spi+bounces-7380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38792A77C94
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FC33AB84F
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6A2046BF;
	Tue,  1 Apr 2025 13:48:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965262045BC;
	Tue,  1 Apr 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515280; cv=none; b=F9yCAR1pXKGficXuy9SJGpD4qba9h38Wn2/wpy7r/VQqhKl5gP2I6DPqzWWxQkf/7ucf6sSxIG3VxovmYn+wJRAZrVZvYOS4zzSrJkMRGyKb1pIy8ufVPT9f3TkthZZFcipzoehDw31BGiq56308/ktwaYAolUPOdXqh4OLr1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515280; c=relaxed/simple;
	bh=orIhHZK2mBXOHJ9P6CPj8DtCz0DKuFngNgPnyToyf84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6XZieIvANOGXQwrzCH2OnL9A346qizSyCP9OBtQTpRCFk8Fu6n/xdSULuhb7eZ8LpUIv83hpMZCZjLoqa4kIGLEjqajJTpNBGt+A6TjnS52O80qU1fGKt977RtP3fcgPTxzwFxYhaUtEMG/VAStviUPAw/x6CigRCdnZw0pTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso9021410a12.2;
        Tue, 01 Apr 2025 06:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515277; x=1744120077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+rx1qskGEkuP5w6Tn0BhreVF2R/OVnokSpbvWp5rvw=;
        b=pmJsMc+cSOOx1739QvgfUOpAifNREyMsF4uRcDtuKdwKrZQG5UvSMQyCtv84uphwsj
         0kkDDZd8eVqwOPqmUk2CBZAbHSKr+DEPvIsuOE3GYuzBDlYwqtywB3Ouiqf1iw2RrBF5
         x8C3g7eRb3T4ri9LmDNyZK45dTImEo+Un4HR7oZklT1WL37IP5e5ILSbVF74hg+JhAoN
         36zPAAxDI5rNM85hJkHMBwgfDKXGS5ZqNFR6ZIMuEwmNATKKXTxFvXOiPEZSbgZ1tDxT
         XFpuuLSqcl20zdwfTEVtJjXxWQ1+eGftYdh9ZrXBcx9PdvfhVRS/cbCuvvF5FngA0lfW
         ljGg==
X-Forwarded-Encrypted: i=1; AJvYcCURB4f4zSnasFcXYCzK+jnO1kJYPgYb4YvxxCmYMkdrIRE+9XSdR6JvA5yanoukohp47d5+B2ubr/kFX1k=@vger.kernel.org, AJvYcCXs/f3A0HDJvCBkteV8tB5OX/unr++Y1Cy2ntNn5WvcBwxfZJMnBFalnQOEHxTewmwqi/s+5lVM0XPh@vger.kernel.org
X-Gm-Message-State: AOJu0YwXahS+YAQ83XMd4CasxR6HcaojE00YOAsh+cyNP4TisonnH13Z
	gZ1Injl3xobw35Nfn7muT43X5GSTtFW21Rbkn9jYafBclWtnvneq
X-Gm-Gg: ASbGncvTt8pLCGZL1GhUDRv0krpAbX0+v5P6SjyBRi8hzSAJVgyzm3NAZcSyXmy1tJq
	JIWjBFj1aACQS7BKIrvsUujGEC4rj7fP3VU3tD4is6gIdDi5TY45F1ZryQdSZgTyBJNPJI2gleD
	lEckIcC0zPyv2tpOvLezM2BxiLexI4Qmz6TbPCecGamrwkTz/j8m2Qak9HZUDRBdmi4VjMKxU6e
	/hFsXtB+VJGGY0X40+Fj3MUtcIvaBD0GX5OUjHsnfi+WpS6XYGhVSX1a/+39FHn8QiIZNWQQas6
	bwc2vJFaPYGQUy0f04VxKqJQqJbzCAKi13Q=
X-Google-Smtp-Source: AGHT+IF1ZqchpsJl91cjnqOW0TqInkBNKXIBilhyIt5S+CcHOTDLL1ou0xV+jViKplohtQaHQNdGSg==
X-Received: by 2002:a05:6402:348e:b0:5ec:25d2:8631 with SMTP id 4fb4d7f45d1cf-5edfce7682amr11659933a12.12.1743515276724;
        Tue, 01 Apr 2025 06:47:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b30cdsm7015449a12.64.2025.04.01.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:47:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 01 Apr 2025 06:47:50 -0700
Subject: [PATCH v2 2/2] spi: tegra210-quad: add rate limiting and simplify
 timeout error message
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-tegra-v2-2-126c293ec047@debian.org>
References: <20250401-tegra-v2-0-126c293ec047@debian.org>
In-Reply-To: <20250401-tegra-v2-0-126c293ec047@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=leitao@debian.org;
 h=from:subject:message-id; bh=orIhHZK2mBXOHJ9P6CPj8DtCz0DKuFngNgPnyToyf84=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn6+6IKYuj1Klp3ayQG0I42YY+kWGh8x3sA5+Lx
 6v4mh/jxHOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ+vuiAAKCRA1o5Of/Hh3
 bZFqEACDPf/gXpU56XhDJIj+HxwyNSXfqDbAYZhODhE8kgP6KjkOZWwTufYJMY7ncMpWLstBcfp
 TSvB2l9gtkkpJlq0p36i1dcMZXpM/WjpNGcEtZ1mbhjQ+NSbbf0Fu68jMpYvGfFJz1vnawGgKbV
 kRSW0SGsZMfdN96xdf2loH+jfGaKkOhTM/yMtWe1cMu5rsf5xkMrnIQEUgw/FYlU5g/YRtxGKDM
 +x0kPH0FRw4FPfRHjLZFTTWJJU/amfvtrguEiWrbhQ+iFTvRZ15FSwbfMvtSfDlz1gtjtrUTQ4i
 3CAhkkjqHx7OBeuTchajs8Q6CFBzXO8pySTP02ONDG7s+ID18zP4Ne64NiNqKQRv43EzEvA+Aze
 yMXDPIlTKci6lJ3Ch3dNMsXAr/nTCmnAeXwB3VCkEmiuAKMXDoCO24inKOYg91aOAgQqviyJZbC
 luL5JO3p6Xzl4mBGsrFTneKnfDX1Dc5UT1GMexWfIve/nec/A/BNdYPLP83fuoO+yHeaNGZz80W
 Po4+jXp7giue21jQBHCEZyB+HOmk9KJiq1FpHFjKu+g+sKtefLlOQe8fnmZrQYudcCtahRl0EQc
 l1lHwDHVdwExl4VjOhJxtxMhoPwmqWzqsQUOZHk1isi4gwTIXX5QdASAGQZai7jcLVnjiL+ySAG
 Lr8Q8v8i0PDOaLQ==
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
index 2d320fbb8875f..64e1b2f8a0001 100644
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


