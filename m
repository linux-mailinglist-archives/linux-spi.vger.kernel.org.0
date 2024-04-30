Return-Path: <linux-spi+bounces-2646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3650D8B6B0C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 09:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12AA1F225F1
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 07:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A8249E4;
	Tue, 30 Apr 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMGB/XBe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFE20DC5
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460640; cv=none; b=EW7IFGEcAzPucyJS4b5mPk1XwUuhSFCqxAVkXkrAprZTExW3cwbvlWt/+e89w2WXZqmw8PkrnvBoGADj42CQ9vwQ/DmjMUErHbQSrejPCtQJFL+hfckKJzWfF1KFjvBPe5TZnaJkSRd15qOG4xl0M9sFaRlC05O+l94YO8iRKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460640; c=relaxed/simple;
	bh=tddqyXaqrdWcIL9CqiT+CC+10z+MZrv14j8mNdRJWcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nert7He4CsmdTY/SAA0wwL+h8xqEvvj90gbct+0gCQY1XPu7QDEja6TtTOuN5Dbn7j9qXmDQQR5oK7ate7tDbXigKuHPfdHaZCBR59Y37cRNS1B7+DFLeWK8Znz8KcR1xPcb6wLp4sLnU1O1YpxunnR4VnKJGEPmiJsWoInvE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMGB/XBe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434d0f63c31so33890141cf.1
        for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714460638; x=1715065438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWNjW60aZKX5jQpzSVa+3L0ZlYdpkfiGuBdJTkw92uw=;
        b=wMGB/XBexdohr+aq6U0avqXgfgwSGpDhRnXPkHE7RkhdA9yRxvLvu1tBhP5+B4Uz3I
         sWgAH/TMh7NDY3eDUElgCwrAVHgVoqRNYigeNmBLnqIezWea2lS+SpA99sieRaXkAKVl
         63ukowCEBy76I+4OgbS8m0lRRmJhZlcZbr500ri0H1SbCWIxYcVGBu93dUhgwgZhnAV4
         J10E8FhIh4sdQwVKJKTxm7Do6P4ULKka3dmtTg7NGkOf0Ehu85zPiBvMLA8P2a9r0Q2S
         nFEpa9KBcE6gIlP+kX16bwqiwer+e8te3Vwc2nWAf09zdHISfxvZUlAbg1LrHGjUZo2b
         Gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714460638; x=1715065438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWNjW60aZKX5jQpzSVa+3L0ZlYdpkfiGuBdJTkw92uw=;
        b=RV6rUsmf+HkRtts1de7ZRHByTqgtGwls9Xbxds3gp06TFH6SGzLZq8Jngy3pYczdCI
         eEa0jStvl4o2D9RcIwwURHiRutPhgyAQIrXVJ/N3aQ8fvE7FR9mBsMrIyW7pZT7eSqia
         z22BXG0X75DRysQIZipEmQB5MNWZm81Im23baAXMhWuGat6EyddepaEtYCpKvY4lqBSu
         WWKcNdO7cFvb6KS0vDgAWUwqwcfw6he/98e7fm+zP+AsNED66FO2qgE+YC6q30iKgFRo
         Tq2hzPpNxws3pK0tu9v4nAgTzKcotIdm+VynvrSfFvVq9ONq5inp1FTzBTKIINXzlXVw
         116Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFE2rJjxllQSTf8FdgxDWZ7Hc+VJD/MZPaUBfLWAmFLDndN6KddAiTUsU+Sga4DLvE4Dy0qBG0RG1D9h27k+pIFNPvczeezuaQ
X-Gm-Message-State: AOJu0YwBHJm6Z/ZUBSEpzCfAc1TX4JdrBFs8azCsrSaO6dLkIFpTklbs
	cGdrSAKZ585x7Tc7jaUUYI62ZAM6PzUC5j9y+b+4ojALAmyFKNlqX+09IoHS+Bs=
X-Google-Smtp-Source: AGHT+IEU/3GWwmwnmPs3D59TLtthT2pwdifoVroVuPln6HkSH63EZK0OfBAJKGQNGC3Wl+aDomxINg==
X-Received: by 2002:a05:622a:2c5:b0:43a:e716:ac3a with SMTP id a5-20020a05622a02c500b0043ae716ac3amr1631514qtx.63.1714460637882;
        Tue, 30 Apr 2024 00:03:57 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10610674qtx.18.2024.04.30.00.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:03:57 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Apr 2024 09:03:48 +0200
Subject: [PATCH 2/3] dt-bindings: ads7846: Add hsync-gpios
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-gpio-leds-miscarm-v1-2-9c94d7711f6c@linaro.org>
References: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
In-Reply-To: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The TI ADS7846 emits a horizontal sync signal that is usually
connected to a GPIO for polling. Add a binding for this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/input/touchscreen/ads7846.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
index 81f6bda97d3c..399c87782935 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
@@ -57,6 +57,7 @@ Optional properties:
 					pendown-gpio (u32).
 	pendown-gpio			GPIO handle describing the pin the !PENIRQ
 					line is connected to.
+	ti,hsync-gpios			GPIO line to poll for hsync
 	wakeup-source			use any event on touchscreen as wakeup event.
 					(Legacy property support: "linux,wakeup")
 	touchscreen-size-x		General touchscreen binding, see [1].

-- 
2.44.0


