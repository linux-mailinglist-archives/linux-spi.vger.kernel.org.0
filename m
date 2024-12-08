Return-Path: <linux-spi+bounces-5959-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C09E866D
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871B11630B9
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF014B088;
	Sun,  8 Dec 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OS7lJW0K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900451531F0
	for <linux-spi@vger.kernel.org>; Sun,  8 Dec 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675432; cv=none; b=f9Y/mmSCRJDRfW+6G9nefiZOhIlD6Hc8kAUOEd0DC193vaFcHlV0WhNKQOaHjxdb8F+Oasv1hZqIR6/fptOkCSYoivDLB3Lsdd1mEeE2EuWXTUIa8NJLn8Butoxdb2uVNR7eUSQfd0uAu4XFfrm7L0CPP66RDArQL85UCpKgACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675432; c=relaxed/simple;
	bh=OFDmGehoK600SvToI+7RLgjBAFQXs+mVcolPpCj+dNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsO/zo0PKNqj+Xx9r413kowUOpqqkJxrXuEKN4k1SIDoFNMgNv/YseZj0E2lrNnGUjngzEVXXn2cynozMl64wm0KgdFTidIPDTwcJ/wVjSykW4laslJwiwvRE5zSgtz+vsICfegaySIzHtrkUCHD5Y8tHKHaSh+Zgitf/+Cl4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OS7lJW0K; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5325af6a0so555594866b.2
        for <linux-spi@vger.kernel.org>; Sun, 08 Dec 2024 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675429; x=1734280229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qhusLfuIgsMbQqxPaQUwX3ow4Gf24/DeZxPYGalAiY=;
        b=OS7lJW0KQwPj/dpK1GsZlGQK16iHFjm/dbXHlyMetzafz2DYnsdy8vBj9qCJJT9MQL
         r1Qco8HEW68kiTVWGTw7+gOrzyMzM/kgyHS/vOZmr5cLxLilwaEQzIoR5WM5qsezSQCC
         defBDd+FhjdybNql+C6qk13L6f0giVSdbO1vvDEWFNpf/OCbPFHBUO6xneIbOe0ygXUt
         csd+/DAlQcm2rB5QCjNcMwtBV0AapOSgwDrV78pVpwyjKoRWFWTyP0mZ6Z2kDZj4O2Sn
         8QzRiQ+4qM8dxfwLD+7KMaMSgiafwcEIBO0IvDJgEnw/Pi3p/aXvmEj7pS0feJAzcSaS
         dKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675429; x=1734280229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qhusLfuIgsMbQqxPaQUwX3ow4Gf24/DeZxPYGalAiY=;
        b=Bvtu/q3v+bdlGYhzdbnPnhjgPOP2GAAIxBKDBrFNWjF6swQg81SUU8t+hQgKuq5+R6
         0UsDDyHxKy23JtZCmGrgHK9aU3o2AsREH43fHp+V/7zmFiQFRunqDy2xh5hqvrildhMw
         0kboPlJRwVtC6vNFHQ2rw7p4lp/vpBfWZV7HgC4xHkOURvQQLNKBhb2y3vtViY3K7YA6
         TFF8ieQGhK8S9MBK3g4MR0JCAnQCdQWcmWR5cKNBJJ1xZUEYu8jU2fTbwK+ftjI/KPar
         BxNwngtqeMWT5lBU5nv5BpAMdaUTKyZbgzAXOGGKY4bNMcF6thxcPq/y/iWsbuur+4KU
         dUUw==
X-Forwarded-Encrypted: i=1; AJvYcCU5DSzX/3J4QEhuzM+aVH2Ons1VyZA2dvVGBpkoU2en5mXwy2IhR8X1SAUHzoMCupQleBkjFPlcXEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4KSJIUwEgdlYJzjfNT9GkVl0dR0BqQcWMkXrFXAK/bW+ZeX6
	30Dhg1lIlQSwrzHZn+OCQOF62BMM4MWcZ0B5Nc10dCgmTX32EaIaggrGCKFqKjk=
X-Gm-Gg: ASbGncuiOecOS/SctJRdbBMK4O7uesSMA2thOTFjB++zIkDMRAUYwczniULs4GVwHLo
	YZG3iKn2xNEQtjbHsS62zoPQEIRcaXxnwVFqufbLuOPBu+hwv0p0S0TMy4y4AXvGgbEI2yLi/VW
	IazKTJ4/7XyVmJKxcQZnkQr2dpbhsnBv/aAG8u0o8paNlraDMv/FMD0v7vuwYiBUa8KXaVqn7hk
	ofWjkaIBAHuRFuJYyToTz2Khk5gOutJ/IV3Sxxy4UUVPIvzUj4N8NcTgTk=
X-Google-Smtp-Source: AGHT+IE7YDoN13k+KH8JOtiRLrAMtuSmlPV0i3qWniWezo/cHtHK2Sxr/2xiHf8TyJV2wCkaLPDXWg==
X-Received: by 2002:a17:907:8315:b0:aa6:7148:91f8 with SMTP id a640c23a62f3a-aa67148942dmr286404966b.4.1733675427547;
        Sun, 08 Dec 2024 08:30:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68a97498dsm5949966b.99.2024.12.08.08.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:30:27 -0800 (PST)
Message-ID: <022a34e4-2a9e-4cb8-8998-d5decc4d9fdb@tuxon.dev>
Date: Sun, 8 Dec 2024 18:30:25 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] ARM: dts: at91: Add sama7d65 pinmux
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <a8f880b89cd4470526a2955a0b6aaaaa24ba65b8.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <a8f880b89cd4470526a2955a0b6aaaaa24ba65b8.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add sama7d65 pin descriptions.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

