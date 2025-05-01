Return-Path: <linux-spi+bounces-7817-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BDAA605E
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E399C1ACF
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37B202965;
	Thu,  1 May 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL/WqiMp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297320298E
	for <linux-spi@vger.kernel.org>; Thu,  1 May 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111735; cv=none; b=F4tzUn6JmG5QYtYSmFI/CdYsIzybrSEcmS0W/pGjNxYOs+XQnutPQLFLLarqDFNOgZewuxjsHVXeARj2ePOtrkI6NcEHq4H1Pzk5HD7cYs+nnkBuuQJ+sIAIH8y1wsRQrd3o4TL3FVrGk6fvfcV4ZDOwzDQP/U9LLFXMC8uHOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111735; c=relaxed/simple;
	bh=wbJvTFF93vO4XDJ3t3HtJwaTtycPFJ1qGS1kFwex8VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKuU74CrJ4LHrW4Rr3MZ0Za/ERDn5xkS0ezPOa/fAdJMfIEQvTA8AZlMuaEkH9fhwU5cHKa1NN2jrkfPjDmzQPsqy/BO/3dG1ogE2eetnmULIiYGqgkoFGXESsDv6SfX0AqGxLphA6BEMhX2BQ/rPXGbK469r8Spkm+ozQAV9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DL/WqiMp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso1369405e9.3
        for <linux-spi@vger.kernel.org>; Thu, 01 May 2025 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746111730; x=1746716530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjFuL+Hxvp62ckp62d4xwkNy5J2SbdNnB8mUiL94WtI=;
        b=DL/WqiMpmHmG7xwuQNyl0N8kugkWsyVp+aKJg4UF+UgSDjOf/e79DYP10ImXkq+KQ7
         4ED+6e4dg3F63aBc5QagIBDHWOmzK2ZRR1/OzjBZOx2Kw3MUDNsJcHWpyrhQzqACQchV
         vCiKtmb/1719Y/ppSAGtwvlQIR8hgxxkdkouusE5KcMw7GP0itQ+mbWbkXg4KKp/k1x3
         012+iiKrbgUmw84yexLY4bKRkHYY18+zinh9zinCmKorqedksjj2mE/8QdEzHpJhVcjj
         0Wgcn7dLCGwPix7KTH8cycJMiU2Yq+WYJ5r4lFxrQTM+UD8QTZOB70chNaw0XZHv3JN0
         HrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746111730; x=1746716530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjFuL+Hxvp62ckp62d4xwkNy5J2SbdNnB8mUiL94WtI=;
        b=mn33f9yfJhdISIcebOTWLxmb6f8hdTY08C7KZyCko6lJIyWuDdUyJFV6Lr6o7toSSD
         t5mxdVjJ+JWHBChFfshBg/ZFgIJTBAsqg9cLC/TN2A6aHywfHmlAOSO96bveaofzUAkF
         uJjwrAEzT2ymY74vvl3qiyYRVPMpqrSBaKypFsJDu2Rjpe/N1jFawhXGZVmKiZ2+NSIa
         tJotpByER0rF4OaqZT48BrUIbgFxh+0/VGydiuM/6vPEp3HBAuz1VcvXzhLvNTpkJTq+
         PM+/32yghqMSFp7f1XmYNMnVQfFoVVhsmRUDjW+o6jTXUMwuAb4c0dqLZqn4nRXjb2Ny
         Cybg==
X-Gm-Message-State: AOJu0YxTdBGPHdY9HgDnpc5lRlyHMMPZETnQpX9eTN/yUmia5eaiT9Nz
	rPeZZECXACmfOOzgSIJ3eoPnej421O0OjJdTqwBMRlKauvwDdTGbFiN5p4Ey1DM=
X-Gm-Gg: ASbGncuq1HkZVZIyG3qpzl2C+tT5anldD05FskTHKLIWtjGjjvJNvKGXC4xWB1wjPDA
	tC1W8QR9yhlEJYNs7NBO+fisR51hQUO0PlyxpAZjOvEpbUbekScRSnvVxdv1xuliqkl156lXPM/
	6puB2Bsd87YZPPOEaH21+sK4lCtTh3ZBRSM93ZgEecIrxjSef6+oUKBU0849mCUIUN6Y6SObjHc
	hw8jjh7AkFVGwLGfFIzP7mLmL0G+okqkjlGkSkplMmnhjDM2vvQ/ZZKS2yCHK2fBjiWeHp+J+tT
	gThgf2OJ6Fo5R4s+HBShcuHWmbBKRUa1pEmUsNWHxswjUZwgkC0hYDQnOYY=
X-Google-Smtp-Source: AGHT+IHx8sWqPznlt7972Iuo2Aq29rBeEzunJHQrQZKTzx2L2RYiG2zZqFAc0QZBwI42PaKv7Rtz0A==
X-Received: by 2002:a5d:47c5:0:b0:39c:12ce:697 with SMTP id ffacd0b85a97d-3a08ff740cdmr2119607f8f.7.1746111730466;
        Thu, 01 May 2025 08:02:10 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a4702csm1033190f8f.40.2025.05.01.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:02:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 17:02:00 +0200
Subject: [PATCH v2 2/3] spi: cs42l43: Make handling missing spk-id GPIOs
 explicit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-n-smatch-fixes-v2-2-d2ad9c1f2e67@linaro.org>
References: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
In-Reply-To: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
To: Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wbJvTFF93vO4XDJ3t3HtJwaTtycPFJ1qGS1kFwex8VI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE4zrtu7znQCsit8jnz6Ax+qO4kjdY1hQPTmwI
 OVVwvysS82JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOM6wAKCRDBN2bmhouD
 147VD/972YtDAImuxcHPXe0MWIDPqszTwkbi59mXMxbvRK6obHdCyrpJkqfn024r4nmdDhOiPb9
 4E1FN0hEFSk8JGbXFmIw22G8Bwq5S0k76HOEPL+b0sGuJi6v5uBoyCVhla5wYn7WGuoKF7wMfR5
 3G/CPkg+jGFN/OiG3QKQ5KM8zlCxT0gAANfomMj388nuUHZSuVD0TuhI0yZS5hROJ8X1RuDeHqt
 /qAObojiLu5fNh/M4xgzFtwpyfd9mR95NFNuR3GYoUIomx4WH0bVbEYFEQuafiUhgf98GIi/yun
 KWucCUhMHpL+B5R5nnhr0lp+gG+9vtbSoNEH2FHo7Ge0+StqKh4wprKlXgVF7Cr7VV6aBZxm6Lr
 LFf5Xov+wZDaUzXgUpRXCYskqUSS4vnlGHlENlY4WU6Gx1pZA/INSKRbIko/wBrLQsnBgaJ8zQy
 ez7jNZlgzRl0LoeE2weS23vDqTEDAsxfRtaAxIky7g0tiIq6IAZmMHkoH58PdxPiG7tmyA0O0bw
 WdP11DStBXyynr8D7wkqgC9snxJkAFL9MuHjwxCdnJJlJhJfl6kOKHeAXSksD0tpm/QXvPH3cKY
 ExiuTU5tkPKjs2lVv1y8RyO4+fmuArAc2AVddNhlCmhSviquLZH4CBGjenXnX82f0vcLkiZLOSJ
 N3UJhd6BH8beTlQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

gpiod_get_array_optional() for spk-id GPIOs can return NULL, if they are
missing, so do not pass the value to PTR_ERR but instead explicitly
treat NULL as acceptable condition.  The old code was correct, but
misleading because PTR_ERR usually is used on errors.

Reported by Smatch:
  drivers/spi/spi-cs42l43.c:241 cs42l43_get_speaker_id_gpios() warn: passing zero to 'PTR_ERR'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index ceefc253c54904b51a12ff112988d1dfbeed39c1..b28a840b3b04b5a4cce15539188bca02bf36716a 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -237,7 +237,9 @@ static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
 	int i, ret;
 
 	descs = gpiod_get_array_optional(priv->dev, "spk-id", GPIOD_IN);
-	if (IS_ERR_OR_NULL(descs))
+	if (!descs)
+		return 0;
+	else if (IS_ERR(descs))
 		return PTR_ERR(descs);
 
 	spkid = 0;

-- 
2.45.2


