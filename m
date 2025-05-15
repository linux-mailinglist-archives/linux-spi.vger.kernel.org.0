Return-Path: <linux-spi+bounces-8141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B28AB8F88
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 20:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BCDA02533
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11EC28AAEB;
	Thu, 15 May 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYqIgeIl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18425A2B2;
	Thu, 15 May 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335509; cv=none; b=Lc35Ta7LYiR+paX6P10i8v8RXnj+1eg5H/npbbEsF+mGaxf/junaetp6H/NalZd5uyvyNV5EM/XIYPbYf5DtEvuIMQDJ+aj57VOOB8FV13UrFZElzXldjvNg9iZzorjqaSTZFI1MYPhYuggwf9OXGRmW4i9x+mBaqZfOcHmmi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335509; c=relaxed/simple;
	bh=xGJB46PlTVyL/38anLkanWSeKgJ2eooulVbxHzP2RHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CizaltNtyFL3bzqxpf2FYgxD1pB/HXBjgtAACIrzlwHLfPiZqxBq0Yuii8MENUWGKKMgnyr9JtMHYqjR5+ay6FWhgvEfHoRRJnviShxLKWitTVErBt90aQ9j+RPjrXAq3q1R2TgpPJjN2wXTrBqz5yzEjfhMUTUG0U4vVSnLl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYqIgeIl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a20257c815so1164664f8f.3;
        Thu, 15 May 2025 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335506; x=1747940306; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAQgWK/HcHL5JZDomkBxGumchi4d3oKcZ0VquzyFHF0=;
        b=hYqIgeIlQk57/JlPdQpFlQz1U5LVm4qqmm2WqzD6fCecMaxfwz0E6/0eG7FAs7DCx3
         Odd0MO/2rMxCxUnt5c8vjCWWshwuUjFYs87LipXF8StjIs32P0NT7BaRbrSb4NxT0sTk
         OnHuoA5cbhyAUHBixlmoJjB+fr9pHLe93fp1AroNiwukd5AAcf/wdwM222pR9PULyTgD
         oI/OQlRkla04nJ/MUnG3ytozwlbMLmKsAIftHIpIgw0fpgHsW9jwFnjh09+14Tn6bD9S
         GziA9qo55wXkHxFNbPcthYrPRqmFqEHXCfzy4qXgnOArr/Lxh8GnF/sDg/ota8WtMsGa
         Mi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335506; x=1747940306;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAQgWK/HcHL5JZDomkBxGumchi4d3oKcZ0VquzyFHF0=;
        b=P4zF2XmpTZX6b3vitbYqrIcMeyJkWrraypiPD4m1O0PQFHIjXWqizbKYWyHPqTVze8
         nuX3qkxXMn3xnn2/Tiikn+6l6jkXhHR8514WXZ23DbaY70itwOiJp2lxmintxAZxldFs
         9bHmFsfULwa8LKEh2cmHm9iQ+OARfMDwP6k+IddTvAHKeEvRDno3Js6jL4wny57FfG8z
         Rlp/NuYA4+ktjl5HWSoEei6tobX36GKJV16PpOjLjYUAaTvSBPtUkPtoZh2W43SLafQI
         DFiGyTd6H2aIf0ATpTLavfeBRqApVWAl/cpSskeY1ZaCnL329T3ajhIzNrKY73pN5FZz
         Ri/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHNmyL+rehbYLlAwOfXLNU2DTV2xRZ9UkjJi9BojwTWeHWDrSdZQvqOgGaFxsfsc6SaMS4gAdHrdT5vE/g@vger.kernel.org, AJvYcCUM4QJ3yRhlwSRSTj8kvuAzko/JHeN5hRS+agoOwz8JtSzr1J5u+LXdBQb8RFFzysaqvoZbPAoU7cXf@vger.kernel.org, AJvYcCWfuh0mo7h2dgLfunwYh4dno4KNfh6e2/U37jOhl5Wee9CY02I8vS3QZ+zaDMnVIO2eSxlLDlyLvIVCn+Qp@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMXXI5Rv2ioPzmJPGtpnnoxoLdDGXT/fgr+xSjV8TEhjE0cnf
	D9AOL/3zlHD9Vo2MPZzj3p3sMeX5sRj6OiinPF5DP7mZQjsHBI0ccS2eJ1SMKA==
X-Gm-Gg: ASbGncvSfz4s/2fMZrCccLohYxE0AoausuzElJT/PTBZXPeagDGeV6IieGS/sKwGRuF
	RmMzU1w7u7YyyY8hxVJP/kE6t5y54bCaMltfQFj3spYkF3Vm/QSZYoWSZnA9kF4HlLZqHXSabFr
	kAI/zoZVgUMoSMi6O/UlpkYR4cVN83Wu4AvfxeYc58XcUkBP+oxkakaIDjV0gZtjKC3/JH8a+fY
	GVhWQiN8uu1Vc6xkX2jCFKMF+2npZIF0yQeehqtu2ytXfMdbn3JYKLJJb8Z9ovZXIxLni883dol
	cDgqd++ECFmb4wfN2DnnzNAwZrgiqLZghcRc/P/m9xMu+ZjhrN/XRGZnQrCU4+g3BxAqQ3fH9Vp
	suF5hO7KoikQbWJI=
X-Google-Smtp-Source: AGHT+IGv5WT6iqGCzdtWMRw7/md5mqJ64SN/PDjAZ3l6FzfhMofC1/5lndV/1swytPL6rGhF8MzLKw==
X-Received: by 2002:a05:6000:2012:b0:3a1:4c72:9067 with SMTP id ffacd0b85a97d-3a35c8271b3mr867307f8f.13.1747335506177;
        Thu, 15 May 2025 11:58:26 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a857sm335778f8f.32.2025.05.15.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:58:25 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] spi: spi-qpic-snand: extend bitmasks usage
Date: Thu, 15 May 2025 20:58:04 +0200
Message-Id: <20250515-qpic-snand-use-bitmasks-v1-0-11729aeae73b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADw5JmgC/x3MQQ5AMBBA0avIrE3SVrrgKmLR1mAiig4iEXfXW
 L7F/w8IJSaBpngg0cXCa8zQZQFhcnEk5D4bjDJWWW1x3zigRBd7PIXQ87E4mQWNqlTQtffka8j
 1lmjg+z+33ft+MGVDz2kAAAA=
X-Change-ID: 20250515-qpic-snand-use-bitmasks-2030c19bbeb9
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The two patches in the series are extending the usage of FIELD_PREP()
macro and predefined bitmasks usage in the driver.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      spi: spi-qpic-snand: use CW_PER_PAGE_MASK bitmask
      spi: spi-qpic-snand: extend FIELD_PREP() macro usage

 drivers/spi/spi-qpic-snand.c | 45 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)
---
base-commit: 4614fd6342ab69feebb067d5db84a9bfb9aada9f
change-id: 20250515-qpic-snand-use-bitmasks-2030c19bbeb9

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


