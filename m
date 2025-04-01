Return-Path: <linux-spi+bounces-7379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C41A77C8A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991F6188F707
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2214F20469A;
	Tue,  1 Apr 2025 13:47:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5E1E51E7;
	Tue,  1 Apr 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515279; cv=none; b=gLCzdoCllW3CgLiTpGm22q5oJ8tBp0Hs40zmHK2KgoAZoS2D/cciX3l7IMXX6SAPnuUgI4WLW6vHUK/zqlGOznt3aaDz63rqXYl13WzwfrItNiSdoyvf6xgbZQzey7nx9//8677Age3ibS1Llvl1uHm+kQ0V6YjkB3gSnwFThM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515279; c=relaxed/simple;
	bh=hOs++MwrUaYCOY1shivPXVBTJoZY0XCnkJVREjJHL2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxp5kYbJZFs34zZiVhxx3AVz/6BlXDPStZVIo6shT0Pxg+ac0B4noAOqKQn/zaWImNU2uYv2PpGd6V2+DRB6Gs/l7OxNiHwSw1ViFL6Kev1xiWNpxuzz0otfuAvtyt0P9CxAa5YQeDWuxPXCP9v65lak6mU+6tVQ2SuIgDegV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so8974900a12.0;
        Tue, 01 Apr 2025 06:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515275; x=1744120075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbHCyAwFaCvDeDpwtBYWOO2ER9i73U6lCkUuCsIXylE=;
        b=tbNi3mttxYaS4xGWcCOYfd28isy3Ve7JYyIkT4og+VfSBviYBkJh+R/6svbcs4sZ/Q
         idDyAWbmbx1Yr+cCKIKK2wsMxN0NLIohdzmaerg1WiXHvYRf0W5u6ht1glR/nDIXFO03
         gHJDb7mqpasuIWBmgGabU0iO/lubENnqwn1U1zhkJq9Nr5HQSekMycDA4hHEq8VQj8XP
         kwYr7vRU7G0cHpCQrNIod3UXLeBZdK+B3ZC/yPg7AieJq3JqoCmhyiLDgqf2NAGKvmfb
         6jyketSx5iTYbEDHCBH861BER23XkhXLhvLGomusDp5ec9NTqymFs7ZJchC2gyPXQL6u
         T18g==
X-Forwarded-Encrypted: i=1; AJvYcCW7z1VmHVNlHOUNy04/EdcqPDlK2ElNRPc6Zxp7WIQvHp00yb9xJA1P3ql1V6hp0GpPjRNX80xHICT+qow=@vger.kernel.org, AJvYcCXmZqZ1KRVppL6t78xw8oUerQs/Yggu/MUlpo3E9ZJ9hNEBCTjhS2brkAyuXjmlwUK3acDXe1u9Nk1j@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiFakUk2fcMN534OPwPyBhJc6TMmtwuNlR4YiPSh++1jD4SIx
	FCiM/mQ3vn1Q+DLtrT17QEJZwYyFUzyuLSsEZWRLH/NGDcbX9gqO
X-Gm-Gg: ASbGnctq9cM10z4Io56k2392ypuVvJ1/DeFPF6WKmOg0jPzp3BDGJFr117BPmYta0PE
	qgpZdQmPP0poY3iORPSYKCOgIj40T43wipXpGbYk6Kmc8E6h4b3eYV0FgP5hTUGUSIDa6KYGhuT
	C9aojMvkWEgZxyqk3ubp9e7b7e5F4T8tiwKQD2gFYoupCQ1lREzwxYB3DQVVAR2GMbLgqz2l2jD
	pLFT0l4aQZI/6TR4RINlYRk9YYD1xHiDqKf8EP2PW6SbbE8SvVNhUzD2p+ja8wvBdbJkhS43BYj
	R+Fc8mZJhu/C/dg/8XilXXM5+3oHwCab8Sk=
X-Google-Smtp-Source: AGHT+IFaOAUiA0127HNC4F1EYvGA+dTW3uSSkUW6Ld9cbie9cNlmSeb7b8CrV8OKh60U4YIEhPygYQ==
X-Received: by 2002:a05:6402:40c6:b0:5ec:f769:db07 with SMTP id 4fb4d7f45d1cf-5edfde2199fmr10351630a12.29.1743515275347;
        Tue, 01 Apr 2025 06:47:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16f10d6sm7205742a12.47.2025.04.01.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:47:54 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 01 Apr 2025 06:47:49 -0700
Subject: [PATCH v2 1/2] spi: tegra210-quad: use WARN_ON_ONCE instead of
 WARN_ON for timeouts
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-tegra-v2-1-126c293ec047@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=leitao@debian.org;
 h=from:subject:message-id; bh=hOs++MwrUaYCOY1shivPXVBTJoZY0XCnkJVREjJHL2g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn6+6I4auklE6e72/KWx8ezg/ZfiOha9yKfuxkb
 JoPbheA1f+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ+vuiAAKCRA1o5Of/Hh3
 bV2lD/0QX3s4v6btBpohw9Yda+5tIWCxGKCaXJrGqigGKwRe1nuf0S6LAAqthV0+1nnqM/PotNR
 H0MM4ZFwNV0EljCI4U9sn2Snc86W5+fwdTCTw1N9ViH4CBP8tgG+bbhcH92uQGZ0kFgsRCmhFX+
 JuOGNIotBYQrscw+iwEo4zZ6PBrMXiNKNy8aMwJoXJ0a3UwCOd4qogZpi0pY1kMWnkEiCpRGxmW
 5uIB/Hi1JZ8GHuGdf8AvD9Ra1vT5TO8JT041aULUsozis6U9MhEQ5/10FSjoQuo2EQPZStLBxKl
 rZ4zhgu5YfDULQN4u/d4O3dVQX4bdehHICUyt+cvpQWgvzSE1GqW/ckTrsqxD9n5BWgy9iPc+tT
 VIPkspF1GId7wGR9Dc3RL3bSQUDNiTjLI+ia9JWiH9q0cZzvARJoq+25142tRzoxw8NAhFlhtDZ
 D0H3vrkjiGjh/b6arnqAfILCgScJrO7X3qrjKkMwL85IygSaMCcHD1rKsETi6zewljMd3ffoAs8
 K4HqSev1DLLrxVAEQMTTg4h50a/x5hL7Yw19s+VugLApk4qsHoPop+mnu+/uq6Fy7iTqoe4ca5h
 HpsRaGUiIy+BTNG70Nnd6GzVmkdqP5/J7Z14kCFv1P1BChl66ixBdLLGGV6texAyPC1jMOJJKm4
 3dgHz2+CoqoLu6Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Some machines with tegra_qspi_combined_seq_xfer hardware issues generate
excessive kernel warnings, severely polluting the logs:

    dmesg | grep -i "WARNING:.*tegra_qspi_transfer_one_message" | wc -l
    94451

This patch replaces WARN_ON with WARN_ON_ONCE for timeout conditions to
reduce log spam. The subsequent error message still prints on each
occurrence, providing sufficient information about the failure, while
the stack trace is only needed once for debugging purposes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 08e49a8768943..2d320fbb8875f 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1117,7 +1117,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON(ret == 0)) {
+			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
 					ret);
 				if (tqspi->is_curr_dma_xfer &&

-- 
2.47.1


