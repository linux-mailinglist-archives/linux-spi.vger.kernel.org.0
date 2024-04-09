Return-Path: <linux-spi+bounces-2251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D362389DB4E
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849FD1F21F41
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536FC136E0E;
	Tue,  9 Apr 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNd9/jG/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC513665C
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670639; cv=none; b=IvafqPjRBiMNFikbp1neJYMTR/8gSzpDQkabL5CJJqO+cbg8m+1ShFLGgWfmGDkHOSc6hOM+r61+f6vTTb4eNwl0bf+Tw/BWVkoAzVsAgqqMV9K3cnuJVTHlT+Bke9ogkzSTopkgBPJKRvRKYCV7UX+zK6BJKA1Pp03BZOF0ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670639; c=relaxed/simple;
	bh=r6A2Tci4Xicv+9Cgy2wMNqtCSb8CDhV6ZEz2Xntv0Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f64Mvv56caxoM2+6dBu6Q1ieJ+JI8JF4JOSbVfRJh0VyRL8O2zMGgc11clBNiC7vIGjCNZqTiaIbxoGP/0vy9v0nfa3qKPH7cftJF5w8Iu9Af1yUrYIwk6ttNPEekCD4G4ptPSDINravx0oBWrjzwvL9DZIbkTcir97uWCwqZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aNd9/jG/; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc742543119so5379673276.0
        for <linux-spi@vger.kernel.org>; Tue, 09 Apr 2024 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712670636; x=1713275436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVQ6p4ilH33ikb+2xe5L6iVCAfwH92fbiPk99ZHEqpw=;
        b=aNd9/jG/wMHKhwXEw5XGZXaPThJZIL+pwQTefL2wKMbcqV2KOQDA0B9brzslhfQ/QA
         CbyriZyZ2zXxrP/q2eVCaanqQNzq4A8qo4jO6PAdmMSX12zdN/0ZDh1bQDVxTb1XQNxr
         rQC/3sKCJgaaJai1WsKsLujp2+KA3Dj2NCOtrtSQXWgdarxT3tNaIG9XYCpk0P1lkP+u
         DM9Po4fs7KRgFFrHEKRsMapteTM2Lraq4QBtz558sBu3fsGMMZzpNEaIRtxDOoxUfNxc
         CqLokNZwypIjU9EGXJ+WJ4nxYdHYGoI+DAPz5AiWhTk5MJG8CIrKB7OKWyO3/Kodw4XT
         rI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670636; x=1713275436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVQ6p4ilH33ikb+2xe5L6iVCAfwH92fbiPk99ZHEqpw=;
        b=Qi1GwpleHqxgzsqINA1uHGUgBKc8IAhzkEJC+pK7HlvRAQxembZwHC3oHZRKPrvtBm
         z8VJO/P5YM7+gGcdy9gaYsFHAyyBqDrnvEn1n2G1WjL+2EgzwwGT0mxMQEeGyfrTIMq9
         Zra9HNUo09tt7euDsYpKy4DQz0L8Qk/PwvWxe2RGjlzxItAuDhymn2wsJeB1a/cMnqD/
         tdBARjd3H0Af6J53lEe+34ruJ47pDi2VjoUnwZDpavy5gj9LJvlLtZBJVao7flJrkWmO
         RR9qb44mBhis+QNJ+RY8zEf3K9bdpCqV7xfqWhKnNXSD1KZ9401lR/fz1QEbHz4fqk0W
         LQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnXt46FPLLrFaAuCWV2r/aHQ/Z3skfG1k16JMRU0wYAOCGgpxRfsyAFJgDpSP4111KAGtWkgltYPpVRnTnp6xr6Osy+TJUgLQ9
X-Gm-Message-State: AOJu0Yy8+coTj/y+5GyLLzH0REQE4ZXDgqpCowKGE9bSfRBNvA64KuX2
	GMWdC0DmaayAakugwfYuLL5OKePM2j98pJ0pQzpj8Rt/DHQyBmf21yFpRRY8yLxloqAIU65Rd9Y
	YwmBxLSc5DO7ZU+rOKsttryIZxTiLKfdj3JkYqw==
X-Google-Smtp-Source: AGHT+IGt7gFQhzP0RwuLz3KK+KACazMzPKbAwJJlIo9r1G6uzcfJG+3e/vv9tQdTyL3Z4BqiXlBKHmk16t0eEgHj1sc=
X-Received: by 2002:a05:6902:2d05:b0:dcc:7ae6:12d9 with SMTP id
 fo5-20020a0569022d0500b00dcc7ae612d9mr11631619ybb.13.1712670636457; Tue, 09
 Apr 2024 06:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com> <20240409132126.1117916-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240409132126.1117916-2-ckeepax@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Apr 2024 15:50:24 +0200
Message-ID: <CACRpkdaWUEfd7J5VooJOAqLHahWNqpai0cChai89vJb_AZxvCw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 3:21=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
>
>         cs-gpios =3D <&gpio1 0 0>, <0>;
>
> Here the second chip select is native. However, when using swnodes
> there is currently no way to specify a native chip select. The
> proposal here is to register a swnode_gpio_undefined software node,
> that can be specified to allow the indication of a native chip
> select. For example:
>
> static const struct software_node_ref_args device_cs_refs[] =3D {
>         {
>                 .node  =3D &device_gpiochip_swnode,
>                 .nargs =3D 2,
>                 .args  =3D { 0, GPIO_ACTIVE_LOW },
>         },
>         {
>                 .node  =3D &swnode_gpio_undefined,
>                 .nargs =3D 0,
>         },
> };
>
> Register the swnode as the gpiolib is initialised and
> check in swnode_get_gpio_device if the returned node matches
> swnode_gpio_undefined and return -ENOENT, which matches the behaviour
> of the device tree system when it encounters a 0 phandle.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

I love it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

