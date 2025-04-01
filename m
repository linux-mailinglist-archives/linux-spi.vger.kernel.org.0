Return-Path: <linux-spi+bounces-7378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87293A77C87
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA840188F5A1
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282020370A;
	Tue,  1 Apr 2025 13:47:57 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A91202997;
	Tue,  1 Apr 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515277; cv=none; b=Sgdmnf+Xcn9RqVBjZCjv2vXm1zBgAUtKS/DnFPkrvm8CYLBDYsQbBF1Zqg8nWAEkojkrCKeeFWnjR8J4edm0MmJpev5VKqMDmvtNMjne+zlodZgRHKwgFEaKSEU6uEzl0oEBesua7FQ9THZrDnt/tGwbKPKq4N5l6Vwybh5LcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515277; c=relaxed/simple;
	bh=plbqHQAdAtAR1q4ivEyKIZ7VRmxPumwIeLB/itxoJZg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=exqI0d19uDU6lj0rMRtgbpK/0nv6Nc7a+05oS7EyUqykOURblNs1HuN3XQTIvsxvE+dBXYx2BnKTJmW1UED7TLDme312Uh5jWPq7tBDrRTkv7QB4t36pUzSjb7o8f32rDQ3+3JmEY2O/1M9EeBP5rpcsXNmit1uInlHVREwD8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25520a289so939334666b.3;
        Tue, 01 Apr 2025 06:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515274; x=1744120074;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GL8jOK1XCsQsfuuvCNPaoHk+TSkQNrLHkh/dsbTKalc=;
        b=n9HvQPlP6r67eNNkVonAjs/5Mp4B/OrbkfeuGnlJMxmduHI0QbZ7OKee/fKnMF8snC
         PyAuZk06wPZ5FKSjZRNMmBfdJl+B+0eb26/1Nuz7fXfplh7M2dWt1tp8ceJy0eywcw8f
         GEH6eh6fVHO6PL9Ssm4asf4CvH4Ko4vZ/M1W6pjRHd+JY1GiBhAcGCieMXpyizzhu82B
         yGrb1LYpmdzXTvfzhnY2O2essCT/o/WtuiNk4JGTvCwst+/wWgicpYSWMm8j9zpfZMTZ
         CfBLI6lvwvmttEcSZC9KaiH7/gmnxyrJR+WOkpI/x4iVbFUnayiof6T8my/AJEnI0y1v
         f7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe9fr/uWB3fC4rWLp2LaoH8Ul8fmqoNeZ5ECa+BHUGOwuP6cmzFTCUnOFxeRiS0kx+UoakPw7YrLbRGqY=@vger.kernel.org, AJvYcCXuk7Yn5frN7x2VkoVYdp6q0C0TxHAaVynFG9nYGfardAAcgM+IQ+g4Mze8oipVvwsbO+vVIipWwI7E@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxyCzaC72oG7tPxHxX5jL2bsy1gm4L/wdvl4yHkuCHbxqzzJT
	YyYXcttSmlFsjRvZyV1AgcadBGzzEEgEgGo0MyaQib8Q5YnKxHLG
X-Gm-Gg: ASbGncu2Heo7wYp9dBRPCV6KgPrOISyKMDxza1mrldBQMkWGNkJXeiMufu2t8EU5UbQ
	Z8hYhryAU6RmeM6YOr6GsEObWEWl7Hi+Fj6IxbnHLjKoR1Tkeqa3x9NgW4FB6a5gnIUF4JLwELo
	eAf/oFFingq6aogEx6P4ZxzNGApEP87vmTE4b1bBqDoaxtlypNI4NotU5pKaRQCTpKE7hIyZvp2
	/qLQjqyJmq1gpkQkg1qC5NlwuQo7n3cB5HTCjcU6Iqj9M2l/+0PWkdQvAPsrh8h/qLjFe4P/lHH
	x4VzbtWDM4XDL4x5/UzH5hGT6F8xWLvk8zw=
X-Google-Smtp-Source: AGHT+IEduLK5xe6YgJYcJbObZxyf2G0a6w9ZWd8D3pQBZUU1StAhYUaqKZt3ovhRS2+K05FzYCfmHA==
X-Received: by 2002:a17:907:3d8f:b0:ac2:4d65:bd72 with SMTP id a640c23a62f3a-ac738bc07e6mr1086769966b.36.1743515273926;
        Tue, 01 Apr 2025 06:47:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71973097dsm756403566b.184.2025.04.01.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:47:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] spi: tegra210-quad: Improve messages on
 pathological case
Date: Tue, 01 Apr 2025 06:47:48 -0700
Message-Id: <20250401-tegra-v2-0-126c293ec047@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITu62cC/13MMQ6DIBQA0KuQP0MDSMEweY/GgeoX/wINGNLGc
 Pemjl3f8E6oWAgreHZCwUaVcgLPNGew7CFFFLSCZ6ClvstBOXFgLEEopzRaaaVBC5zBq+BG7+t
 5zJzBTvXI5XO1Tf30f2hKSOFG4wxuixxGO634pJBuuUSYe+9fg0UqDpsAAAA=
X-Change-ID: 20250317-tegra-1712e60604e6
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=leitao@debian.org;
 h=from:subject:message-id; bh=plbqHQAdAtAR1q4ivEyKIZ7VRmxPumwIeLB/itxoJZg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn6+6IpXKODkNNTJLE2h8Gyik5JGsGQfvQJq6Ao
 dYbi0SFO+2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ+vuiAAKCRA1o5Of/Hh3
 bWAgD/46V2r/AzVhSSba4QVSKb01AxfZELXncSVlawyu3stWHbTHoZksIzmoZJ3pwhsSpUQc0GJ
 GupgIIEWHmPS2mlK/+nxYh5MI0O2hCSAt7VrDp/EagL/vMwOHwdJbO7y+19ArJCzI3MQKV1gedp
 +ivYVsa+ZkveAdV+o1NyA0cmuf6ZupTT/WLTvqVvmMVbWQ+/txK31EtiEDpdPYuGe2vCm5AaiNx
 +vt1u1+Ubx8GlyErFcKdm9BZ9oL7c1U1TYCxHN4ok2WPvPVomrZrcLXrrdSwxoNcpdCCOGiVhnj
 rE5J5oPSvCC19ecLtf9HeQU2qUhgoflrS45DpVz0Ye2HEgjkaUx6EbD7oRHnHVCyhRvmJAc4o3d
 ahgZ6lsGBjwFJtzuwZG6ymOykRxKvvtSko9mY+M1AzAU57ABS9VkS20x3uRsIP7TsYn662oiJbf
 Q6ehlz8bSOWGQMwyBmb0MpoS7sMWoQrHHFUgH2ECzzjogjyEVhI3GKx/qmuYOx/agP3KnyaTSsO
 fdI8w8vJ1WsxjwBNDYy3BFUWFpXRAoY4EW4BB5lVC6fZUxBmL0lX5Tq5g0LFBSCH0C6TtqxF0nA
 VBJIJgKFuZ0944E7duphedXCTvVbcZn57lv2dZjZlSYPlbovhu6MOz3vwmIt1Pu/QHwea7pB0ym
 J7rq75OxaeARL0w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

I maintain several hosts with tegra210-quad controllers, some of which
experience data transmission failures. Debugging these issues has been
challenging due to excessive log messages from the driver.

Since these devices do not have a way to reset[1], then we want to avoid
warning and printing a bunch of messages, otherwise the host will
overflow the serial. Fix it by:

 1. Using WARN_ON_ONCE instead of WARN_ON to reduce stack trace spam
 2. Rate-limiting error messages and removing redundant information

These improvements maintain necessary error reporting while
significantly reducing log noise, making debugging of actual issues more
feasible.

Link: https://lore.kernel.org/all/q53apce4sltvnyd75j4o7taatocxiduq56fqsoxp3vrjmaqphk@o5kce2wb3dnz/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Dropped patch 1, which is still being discussed. 
   * See https://lore.kernel.org/all/20250328-cinnamon-mushroom-of-proficiency-a17ba8@leitao/

- Link to v1: https://lore.kernel.org/r/20250317-tegra-v1-0-78474efc0386@debian.org

---
Breno Leitao (2):
      spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      spi: tegra210-quad: add rate limiting and simplify timeout error message

 drivers/spi/spi-tegra210-quad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250317-tegra-1712e60604e6

Best regards,
-- 
Breno Leitao <leitao@debian.org>


