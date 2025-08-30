Return-Path: <linux-spi+bounces-9818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB03B3CB35
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F817048E
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA1275B1A;
	Sat, 30 Aug 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsH7eFkF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14372144D7
	for <linux-spi@vger.kernel.org>; Sat, 30 Aug 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560376; cv=none; b=fm/aNMmthN1NIFGUbOb6xwTYJJ5bGgUK93Bp646JEbF3CwO9ykCCB6TkXB2XdvgU2/m2QTfOrDHMUZp1oq9Jr9wH7M6MTHxZJg7pm0hCY11eDrPtHF08DA3zP59+rs0dgfFgvrOzQ6E68eJR7MOpJOiIOOoYMQaDZWS2dfDldis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560376; c=relaxed/simple;
	bh=qwG4c4Xd+B3YoR0uF7y8E1dHfmZd2XS7G30El+hHeyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRQ3/0laAmsXHbG9NtyDULGh6gqYi5t8mB/6LGKyAy1y0pObsfCfETGs/rJVHSLYvmhy/EKwSSc9Es3CcX8pb++7OIDB9YzGyoUUJMjuwuBaN9yI8CfUgXOjmISh9c1WzHIX9Cn4yMynTS8tCEY3VtaIAVbu493c21UWdYnON38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsH7eFkF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afe7584b6c1so40134966b.0
        for <linux-spi@vger.kernel.org>; Sat, 30 Aug 2025 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756560373; x=1757165173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxv0MqB/ujP6vHvTc2WwDI6QNrDWWZGMfkdvAnlFnuQ=;
        b=TsH7eFkFF9werCsKcPtU/X57EogvXskDw39mx3se32vryutXUZeD41/bBX12tkm2K5
         6xZYbtaDe8i1M0NpZnl6F+f3N3k9KTDzz3fowZ3UtcTDZ44EbvWTkFU659gCwYCYNKvA
         pt+vr6Zzp3NDWULcpUC3GeHkHQOUULHbp4rm6YhQh7bQyCN+LSQMl1wXEgjNHuJlCwgb
         wIYEEbrslzyAErutzabsfNvZjriMEAt0K0ISTqRtkfu92dxcsSe069MCNjD9POd55WI2
         2Fe80UBfQda565Ku18P/MrpboWgrEc4Nk+d6TGiJ8KJXgRZ/yhgubwMB4WseToyZE3JW
         UR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560373; x=1757165173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxv0MqB/ujP6vHvTc2WwDI6QNrDWWZGMfkdvAnlFnuQ=;
        b=OxoPtNFsh5ljrEUTjSq42fqRr+L7XMV26iNs/80MZufJo9ggS0AHjB4WQ9IvQrtqBv
         BFp07XqUaOkSP2HBhklbB3Yup2oHP5ut+D37sVtYiRgUcXkeyk3RDrDDt9xjLHmt56fh
         CNIjcgnUJXdLcWbhk2YIj8b1CKw5UiQBjoMiQB7ijmYq2wkl/FOmM+/DH4q8schuJkFz
         97xh0tF2leUN8tqmUdYPwAJGRVYHPggHnDWFkyCbjIWvlbHgYsNPBmCoLyxK2SswBKe4
         grF4vDKOmdgfHTi90D3evtiN+RUr2QAuodFX7Xo+3RRVmeC+B2qD5650AoSE/0YizamT
         bVaw==
X-Forwarded-Encrypted: i=1; AJvYcCWNFl9SpsoOKKrSJPP8VMJWE8z9ToUPL35XGT7fkLJwdfXxKXg5Qr+NvrAkwosASSixcndsOM/Vrk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIJW3/9hdR/5iSKJsGsnX9BmnyKdRqigjpvENYEvp+cO4mVoO
	C6Blafz9Pm98o9puoCbFBSfnYF6Hlq4i0zoX9MPT1aKs1eg06UIQby/kwaNMtvfz4nI=
X-Gm-Gg: ASbGncuoyLREovkxlayZEVo0SyczSNAd3cxs73tKwJ2LJGHYcz/ZUVa5yUwtlR0O+1v
	ZnH2YwZDpHCUrLGSp4uwF06FeEZbJt+xyr0wKh3GpGRkq5JAI+xevyiR5FltJZpxTZnKlZKDHuI
	nz3Ehg94whmI8nMOsbryUZqsWr8eS6a1agnNc0N2uoPh29LXeRxBdrnxZh2MW40lLNNtbCfLj9F
	jN028pwt4aDMR7HvgPGbs/eky8YAiB13+JYAtTSO3MSHdrBLWLZMC7xZyUpcBIdBfvb7pgQzfIy
	ILyor15HWoVoEW1BMVidCLm2zWsxc8K0nb1yZV/ofCelJeHwG9FRGn38x4VjQI8V02cWxrMdY7J
	XBcOA8b3itpR/tTyFjhvsySjARRNvMv1QKic8I5H37Vgw
X-Google-Smtp-Source: AGHT+IEZpDjBctuWqYNRlyG55Wa6Z7JlU2nXfaTVYBNjCJjgFc8SZE+7HVHp1fu8CNukponM0TaUCg==
X-Received: by 2002:a05:6402:2110:b0:61c:7c3e:f7e8 with SMTP id 4fb4d7f45d1cf-61d0d2a9310mr2165499a12.2.1756560372888;
        Sat, 30 Aug 2025 06:26:12 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff3dd9574fsm225212366b.84.2025.08.30.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:26:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] spi: dt-bindings: samsung: Drop S3C2443
Date: Sat, 30 Aug 2025 15:26:07 +0200
Message-ID: <20250830132605.311115-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
References: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=qwG4c4Xd+B3YoR0uF7y8E1dHfmZd2XS7G30El+hHeyw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosvvuWOMibAY+sCtkr0eJY9VfamQvRG859Wy96
 p5TeNtYiMOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLL77gAKCRDBN2bmhouD
 1xXUD/9qOZnQ376tzF5lwUEClQkuLBudqcuNOfdDxwqUDHTvhTcOAWvj2LAGTmF9dF3g1gaNxWt
 ABBXRcxT0uLEoGRNlwKDKAQ7VJ5jUAcckldLBROWWIOPCehaoLHXK/c2rgQKUh8KLyNdGOCK7CL
 ebnU5WbX8ihfVb9s9hbyaQxyLEs0KfONYlJkkdOf4Ui3n1/k1sPqAAucyy0YpiFM9//NaNmXXFu
 rNk5FvCoUTHSeeqGnpzUNc/f9GOZ8YAFoggrq/iHgZs+EIsBLvqwoR0c+x/TL0E8DI6cCu6zNJK
 tCNPtD5Zf2PCpCr26GurjsYx45fg4Gc6FAZo0DZvNDzYV1BtNkvdELIAUZP6UPGFg8bto1AOlqi
 P5CBHIp3cQ/GQfm9+jrmwQAGJ2DFl/eFBD5f6uWB6PkWQlup70I6z8pcbDhnChjj9mUYJ6Hj1yD
 qLzs1EVfH2AuYHR767ZQZaHUtV05/HkftI1Vf9h9xVi1tmOOFSMgNQaAnnbYKOi9dF55Tg7nl5E
 B6LRtTB+RGr5fh3Tf7o1uIIOK3LQ/LtXhuV3mD85MgoJp4TACcr1+BMtzyQfYkKZTIpw4Kd4O7d
 2fMfvxUSE25mvLYJ86YpePN0AOEx1vsA8n1MqUe0KoURjZrrdqvpSS0zxG4RR/U+wgJerDV+G/B W8W9Wd5GXVLh14w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index fe298d47b1a9..1ce8b2770a4a 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -18,7 +18,6 @@ properties:
     oneOf:
       - enum:
           - google,gs101-spi
-          - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos4210-spi
-- 
2.48.1


