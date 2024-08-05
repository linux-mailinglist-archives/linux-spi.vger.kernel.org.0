Return-Path: <linux-spi+bounces-4142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30122947BB8
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3D62837E2
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24F155C8D;
	Mon,  5 Aug 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbnTzin6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7F17C;
	Mon,  5 Aug 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863919; cv=none; b=Jg8mjxyD/G5przvvmUsD1V/AXU72eMCAD6UOVE/B/3OhGdi79DtNo24dDYckgeQ6iGWR9jxSmcK3rNUR0NJzt/yKFlnusOMl230qgcc7DLUO6PwYc5WAkh5HyxoIDeOmQDuTsQJrkNBHfmzrdUxNxIETZpoQgVZ302ZjoQ+1LH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863919; c=relaxed/simple;
	bh=hZKgDz/SDvunnm8VKil00q0C7PMh4gQQnXG3uCtO41I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxcSkNvk79el00He3MZTg4pxmqNXoLQssT9Yk0jsSY6jOHpAWrwn1ZL7DuT/ry0yp3zUq4vbBLMAl5jQkya5GiGIysh8M5cD7fBPI44N1Wddrio3I75cGOy8jM3ZhqpbZ0evw+qrOxHZcgv+0AwNY74GTU6WhppOzFIp7wKJZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbnTzin6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52fd119f09aso846326e87.3;
        Mon, 05 Aug 2024 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722863916; x=1723468716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TB2LRZsxa1zW3MtjCcwpxmhMf8zRqbS8n2AwXaKmjs=;
        b=FbnTzin6Ep9Sw1JNOo8IBohpfu55N0+j5rdFKh8UQc4TmRrqNYnVW1jakk+jGvxi3Q
         9MNh0+LoaUFLtJoDlXqZ2CQ8398jSrqTminAvfnGMKRXWe852wnYh+kvFAHczH4sMgW/
         oZ3uB+bKXWr+uJQXP+6A7EYQIMc6r1h0oPwpSfR4otbWGDI2HtiLOEoSzEFGIXMoqbqT
         RXcstkiVc9mMF2skzPkpvBctTnnjAbZT92+E3jpaMomsRN7YA18ZmNBqC2eSZfsNgU5x
         I00PKDxvEl8PHTB8/mnZqI7HFTVDCLzLTV/ofk9anQEaMYF6bS6LCL/MPJcqFwQmR+s2
         cpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863916; x=1723468716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TB2LRZsxa1zW3MtjCcwpxmhMf8zRqbS8n2AwXaKmjs=;
        b=tHITncaw8hc1OHeQrD0Nmp9vYokKO8ayDc71jnTop0aNjdOHuU+6PJZz/zFuq8F9PQ
         FI3swS9i6YmRqfW+akpIPcYDq0vC6VBSEaSpX1gMbKQiMHwhWYX/BAaMlQw2VBfbE65E
         eA+VPP4QzJV4dOmjQvIpuccubRR0A0mhMtjzs69QOHixhxnuqrnET7Px3ZUAN68n7zyK
         ST7OFMnRz60MD/O4iRTlrpvaiIsl2l8zCQ4q6jO0Jaw0HCu62wHK2EKUF5Qfgl+FaJ+I
         uq2ExC4hza3rv8F7l84NSj1sagdG1DIiI3ajf/t9ZyX7Yuh4QH0o53hMyDsbA85/kywc
         F3gA==
X-Forwarded-Encrypted: i=1; AJvYcCWfEG6ZQoW4+ZoYzs7xvoDnFOGncEZ0Fg/GLk9nyuK7WUwZOWdQ0GEksbj2/FzQ3a5QBkTf9Gbu3xLI@vger.kernel.org, AJvYcCX5ZtTAPXY2gG/AyaIcG+ZX/E12eKt/IKC1uGKszAFylsDiJJCf/giZ3CtwI5dkqZtNKIkMKdcukJpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUy90QXqL1cWDZZQ5+tpSFyEmn+EFRc0N4BQF98FUz57LXsm97
	wvqfrajIED24kjB70nTfI4eb3eAli1dtrxvcvkcNlVtpDybirZiurwYspxtclloDsIEwHLEBINv
	UrnRUg533Imsx/FAU6BBYtkxcOgk=
X-Google-Smtp-Source: AGHT+IHzeYF7oy0tvM/eppdRYZbu6sJTd9gmWgAZmx7bJhZMvFJLykcOCBOCK/iZTct0puL95X6BwHwASV0e6rsyGz4=
X-Received: by 2002:a05:6512:2828:b0:52e:93d9:8f39 with SMTP id
 2adb3069b0e04-530bb3813f6mr3982688e87.3.1722863915355; Mon, 05 Aug 2024
 06:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719111210.1287783-1-festevam@gmail.com> <20240719-unquote-query-a76fd9487bf9@spud>
 <28702815.czjnFlTdjD@diego>
In-Reply-To: <28702815.czjnFlTdjD@diego>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Aug 2024 10:18:24 -0300
Message-ID: <CAOMZO5AkvxwRrs0BHk5qe_YM_=Up4OYpOrp6ECaLcfd=VhjV0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Conor Dooley <conor@kernel.org>, broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Fri, Jul 26, 2024 at 6:57=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:

> with the error Rob's bot reported about the usage of spi-cpol and
> spi-cpha, it really looks like the bindings needs to be more fleshed out.

I just wanted to let you know that the warning reported by Rob's bot
is very old.

Running "make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml" on the
existing tree:

  DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
rv1108-elgin-r1.dtb: dac@0: 'spi-cpha', 'spi-cpol' do not match any of
the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

So we are not making things worse in this aspect.

I can work on removing the warnings as an incremental patch, if you agree.

Regards,

Fabio Estevam

