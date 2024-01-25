Return-Path: <linux-spi+bounces-741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228CD83B69B
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 02:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470F51C21BA7
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC267C6C;
	Thu, 25 Jan 2024 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5ZuQX6T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D21388
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146540; cv=none; b=iHvatxXfruV57mtlBfLodtoxc+1tj0lo2M8xLmN63mFAOXs/1hGuZ8BUxtmLUvJVZ1O72/bHNBNVPFOe5XSdxX4tmNvm71c57LbAx61BjMjvvKaW99bwLP7MjGeuxqxFEdEg+rxZOnflfIiKRjNk/UAIkHcY90b+j48qJc/sf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146540; c=relaxed/simple;
	bh=gvS9OR872hMLDwjbJt9LD4SXHkhJWBAYwtl2RkaXhw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFC9iI/rTgwriXT65xNq17mzvecUhuq5Eth1zC1KbQlEV8JpMd14eM7tSmoOHNreIxWg/b2HH0qzfgYNVYNg+6etdVzVloPZnfwxbbvKZtVEeBm+sYROjQ7dQGufbKzqZV/0EdpjW8KENi8TIBapdvOu2NOOHW1nl5rs2E73Fo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p5ZuQX6T; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dddb927d02so3630268a34.2
        for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 17:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706146538; x=1706751338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrTPIRFEFJl4D6usMUg96I/YEqaZ4s0DmE7WQLKQltI=;
        b=p5ZuQX6TGPuwjyR+BO8s3gBt2K53kor0tQRxtY5zOTX9sTgzaXqwZi9t/CnYxL7lE5
         oNTcrBK+2RC5w+btmrCX6kay19xE8QJliMuy9wmP/+dZsSZc+9vNI0I9AfOi9ttV8nwT
         HKzE8CA4p71t2kWVlNKKyZgcsmenp3RRNG5CrrqwvuQBDWz97cNtmBJ/WL6OR1m+wgO9
         9/QudA7RgGolsA+iCDrDr6VmXGKtOc9y3FLPgtyKHiRMr5YnBOfuI9pyXR9M+LyxPaIu
         Zr+TjqYZLVfhbf6WMZOKB3n/WuKSTH0Ln1XnMwLgn383PjuFGlpQ0s+miAIR4qjJRRsv
         PPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146538; x=1706751338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrTPIRFEFJl4D6usMUg96I/YEqaZ4s0DmE7WQLKQltI=;
        b=mHRSjcVldJajh4YTJqVq3YBpkNv72LNZMy+7s89UCE8cJP5b64ueSb5QqVhun+RS7A
         uWf/qnhYiYw18kE+4AFpmjZ4VvgH4feDE5iI0XhBfzhO7yLSItRnjKXAZ59HsWiLXeN1
         jNKxe+pkbkYyxLfLLyV6x8VHpAqUbEE59ZuWSK4SM0wWcjdljJv60JS6yUcBiH9uES0X
         W4iRSTwlJsb9SiMVaKEC3oFYF7xFzWQ695RqcXjzW7vUncM4hHCGIn+LJ0bngNZkn+tR
         w76rZZLXxhZZEy8I33JBZSFfPRw+L3aFdV5gqWmf1lsGorpzwEudQLJ90P70X9JC9PaI
         CFfQ==
X-Gm-Message-State: AOJu0Yyatxf8e0VsldoHXwLtQXtH7n60sfljXvjFny4KVs0OSYfV6/7J
	EScmiD+HG/m3HzmRXqRQdYvGYDGYUPBXRJ1xQ0sIZIc2RpZILQJwzIewAQVicGVxIHekEG/7OER
	B
X-Google-Smtp-Source: AGHT+IEiF3CQdPoY5jyVBG7JBTXllVCtLJ+MUSyX0wMqIAPSiBv+se5HB8ZlaC7NoLgvBlhEcAeiFA==
X-Received: by 2002:a05:6830:6c18:b0:6dd:ec7f:f46d with SMTP id ds24-20020a0568306c1800b006ddec7ff46dmr197894otb.11.1706146538402;
        Wed, 24 Jan 2024 17:35:38 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id o6-20020a9d5c06000000b006dbffa39d39sm2834483otk.55.2024.01.24.17.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:35:38 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] spi: dt-bindings: samsung: Add Exynos850 SPI
Date: Wed, 24 Jan 2024 19:35:35 -0600
Message-Id: <20240125013536.30887-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125013536.30887-1-semen.protsenko@linaro.org>
References: <20240125013536.30887-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document samsung,exynos850-spi compatible which will be used on
Exynos850 SoC. Exynos850 doesn't have ioclk, so only two clocks are
needed (bus clock and functional SPI clock).

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
  - Collected R-b tags
  - Changed bindings patch title to "spi: dt-bindings: ..."

 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 79da99ca0e53..f71099852653 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -22,6 +22,7 @@ properties:
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos4210-spi
           - samsung,exynos5433-spi
+          - samsung,exynos850-spi
           - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - const: samsung,exynos7-spi
-- 
2.39.2


