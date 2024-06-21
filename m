Return-Path: <linux-spi+bounces-3535-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42E91304C
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2024 00:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3775B21B13
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98E16EC18;
	Fri, 21 Jun 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B95zU5MN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBA16D4D7;
	Fri, 21 Jun 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008679; cv=none; b=frxiK3Tr7pOs5iALfiTMeWU1WDRsWUKgUPh3zLc29dfFOkbjXIwgd/USAKwuQykBB3fJiyAWW1KFJ3xbD/AFvDOuGLOwIr1X8/gN0apRd4zf5EwbNPEo5EAZClUn3xlr4UQ+JcH2nSYdPZywyEnCJw/ciQRycC/kOTM7mKauWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008679; c=relaxed/simple;
	bh=W8+g6q4kiLEWoFiZsO2D1XPUQQZnUuCTYPFgCkLPpkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3u+j5yDnU//4IHPTpBeCSbUQpcfTAEcUuFsyrh069b98ozLKcxtTqeRhIj+KhB6iKsKiVlDQigvSv+tY4y1faZYW60NC5l9iERCbqUxtt/wCuoe0m2+E1VjGEJFHMpFteSaA80zd1voGYFVoljDxigpdsqSRJ4JUiJ3eJlWVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B95zU5MN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9b52ef481so22366655ad.1;
        Fri, 21 Jun 2024 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719008678; x=1719613478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPINdJ5weZIi7pTUz1I0v8Vntjpj8PCNOU3srGBgLaM=;
        b=B95zU5MNyDxA5eueKw+1eGRVSDuRqEEqnAIP+77w1LTah2I/AFehX+13NQApZOyqdp
         gn8IraOMy8o6ROQkKLI229NK1XkwXON4TaYaKWET7f7au/vb0uYLYVk1/+40uySPXeOs
         5COrwAuWyuGa0cujOzEEWSaNdKIEhYQI1D19yhVW7xsVhhK2kAs1R5d37A+wtED85nDq
         8LatHgIm6zam/WSHY45RuapOpbFFRCP2sp2UNDCh3YgImryw3U1vAELxUuK/bSp2FADw
         R6QOhLKmNX4gdEnMHMh4w83nCSJOscbIGTavce0KvGopDAA5HWRMNmYPU0hD/l0qa36D
         YkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719008678; x=1719613478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPINdJ5weZIi7pTUz1I0v8Vntjpj8PCNOU3srGBgLaM=;
        b=cO/daGFhwGP0vhu9A+k1asr5geYUMuvnz2Sq6VeljwX8XTVUI3b+XE13IAOe3t07jh
         q93mFoudI2Pb35NKildjsDkeufXvi+MN697kal7Td2Cz4UZhr1I8T1EPUvMfL4oXC1R/
         SACeYj9lE5wStnj2x7w0r1o/Jd+2lvnbKK1TLKtxePIDlQz/hJdC9DJQWLPCmi+gr8/d
         oOCHwpLSusB6xe6pVs9Rh6LJ/tLMn5WivZvqgQA8V+tgeO9bZKpdbD5LhXRFlcdxEftA
         rfSdsL2ro4ri7V1NmitgtnRoDUs7YT2UJivxR3BrHZa9Z8ez3uBgXqk2NsMIN8sPMk40
         SGQg==
X-Forwarded-Encrypted: i=1; AJvYcCUqTzhLAu3r/sENggkKUqYLlwTmEWaVzlHfjIug+twVXOySPVXQyoUSaFTnET2DL2Reouyk1O/kWh51DvkWIbnlgWH75pVDC/eHYQ9Taq/21RTjV1Gr7ZPR3D7RDm8GIxtq58hqlcGC2tuOZsL7QZPpxqwdQTQoEcYAkblYfwjN9AQs
X-Gm-Message-State: AOJu0Ywkk6pZZi8X3VMMbW5/CN3FJtrgC3T3HpJv5k4fpEJ6/ueSaoHx
	O2+3UxR3SQegk919ZIUqmMNTpI8rzo8L29VCtyN1gTbPVQtfr9Vz
X-Google-Smtp-Source: AGHT+IHpWuFhMZN/VKSq7ivw4d/+jHEF5xGYlrycnKN/ycvo6XqCtbwnNnwN7Bg80/zGA/lvXx969w==
X-Received: by 2002:a17:902:f685:b0:1f7:2479:a530 with SMTP id d9443c01a7336-1f9aa472db1mr100127325ad.64.1719008677592;
        Fri, 21 Jun 2024 15:24:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:30ae:a791:227a:a35f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d51d2sm19028705ad.198.2024.06.21.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:24:37 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:24:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: ads7846: Add hsync-gpios
Message-ID: <ZnX9okC_uI0gHD_X@google.com>
References: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
 <20240430-gpio-leds-miscarm-v1-2-9c94d7711f6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-gpio-leds-miscarm-v1-2-9c94d7711f6c@linaro.org>

On Tue, Apr 30, 2024 at 09:03:48AM +0200, Linus Walleij wrote:
> The TI ADS7846 emits a horizontal sync signal that is usually
> connected to a GPIO for polling. Add a binding for this.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry

