Return-Path: <linux-spi+bounces-4448-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C6965028
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 21:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713621F22287
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8444F1B9B38;
	Thu, 29 Aug 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb2WLfRh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E51B5EA2;
	Thu, 29 Aug 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960605; cv=none; b=oZ78s8YW4XdVU1XrW/wZqGGiNo4Ke3ysQixCV3N6gdCbkvhkiQqTk9TvS9Y1sQsbwVRQ/yqh51owBZjJ/QkRPuQFAJVFkOkcVjJpP0tltCsd7dTZK4Olnq/bk2HMb6gICmEz4sCe5gJOBmYN22SfUyrRvJFXjCy0Fhb3wy1BvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960605; c=relaxed/simple;
	bh=TBxB5gNtR0g6Sc7FIRdzmctXEQoWo8ghrEmTBIKN/M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mACgSKIdMzykHMl69iizQkvKbsZ+dfSIo4357fIeEAwm+CCRdhmIU6WkS72EHAKcmYmVrXnSuRDg8pz2TlHrDSrbBrowq7juKUXLeX4XHkEVtY6tkrRRc3m0TXUCRessdOeAlkDgbdwqKe7pyoKUJSZjbp3iKF4/YUnQVaPBrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb2WLfRh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f50ca18a13so12665561fa.1;
        Thu, 29 Aug 2024 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724960602; x=1725565402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7ymyH+VGNuqXiiTJMB4bfxVNnpZXtZod34IUt36qTk=;
        b=Eb2WLfRhrRWToZsdRkwncrOaGyCpGuRqxX25TtxvR2MFM9NJR8gOICaO5hKAcJFe/+
         MV08yIhut+mN5w581uvZSaHX1iqpZhP4KnHIyLNkPw/02dsvLnIIyS8NxONfdm3zPaiC
         iQOSsPSWN+RPHq/Up0FyNdGW9CPTIDXOCBPMbsIGp0uIKhYflnRDQfQKH2FDgyU906Ab
         hDOQHXXod5TaXBIPVjCQ4e46Sf9GowIwOA2DVYzRiD1pX+IBT/TO4fOhYcoqX5t/czxs
         apRKtvD6xEyPV/SEAC3GKZUIP1fQm8Ybok1GtZJ+pPySqoSHa1q6Ciwf48DczGGqahXR
         Mcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960602; x=1725565402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7ymyH+VGNuqXiiTJMB4bfxVNnpZXtZod34IUt36qTk=;
        b=ufV+BBwgTj275mxQkcTrlZmI/l/Hd3U1lh0Todkc9y6W6CNnlQ7xD9jwCG8HVQJ/Bk
         50B0m/fadnw7IJAjSYZWnpq4Kn46UCktS6rtRgfHru8FS0PJm9OXHGSCjBM0/Shza+Ap
         IqwuCEwPmAYjO55UXYfIlo9MBHl7X0o6qpp8QXn2JE/tmI+sleIGiCjGjbQZiGX1K+KO
         4DqPiwEJE2tEbvjku/E/PC6urjucMDM38LU02lM/a3ZHoV08mqfIQo+sAzPO4ao7MB8m
         Qx86sx3vR59MieXKLGW+ulA14yGJOu9mNPxOX0PIZ3XriuxpLAcO2sAjNOe3qVem3OAO
         JVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQLCj7IhDo7eCym/KddnWL0HEDBOF2eoN65gBIeTTJaorFqFBWZq3tIqYjbftGOF15KC8QUj+7ATH@vger.kernel.org, AJvYcCWO+KroXmL6FnhtW1/ilxg9ekcR68slHFKjSAWdiiuyGwmKjnCAuWMjJ0XwRVCIZxDpyraidukXX7UJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0pmDEWQMm+Lgu2f7mcmU0zIR50XJ8FOzxPGMN+zV+4Bwv2tb
	9ThckUgJDtYoBBHNwNX1mNjlIhke5OESkO4s0ayW4pN2bLFDvyurXBeKXfv6flHeVaNNZZqd94P
	IHu3Z2MdHEKdjunoxdD4IwmsPV3c=
X-Google-Smtp-Source: AGHT+IHAhKvqaG2B61c1rQutv9U5NZO8wr3+G/TNoQw8GEgV6m+Zb5FKCqXgJxXcCJ8NzxrGw/mMxNIQcJKYeuql/dI=
X-Received: by 2002:a05:651c:547:b0:2ef:1b1f:4b4f with SMTP id
 38308e7fff4ca-2f6104f259bmr27285751fa.34.1724960601288; Thu, 29 Aug 2024
 12:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829113158.3324928-1-festevam@gmail.com> <172495658983.899923.10430034751474903183.robh@kernel.org>
 <CAL_JsqL7+5q=7rag4UqfHUR96ii-j8vDksRj2xWnWs=Y_FWU7A@mail.gmail.com> <CAOMZO5DVnwrLcswA2sV0EfQwLJx343B2Fq76boPzfKExu1u1qQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DVnwrLcswA2sV0EfQwLJx343B2Fq76boPzfKExu1u1qQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Aug 2024 16:43:09 -0300
Message-ID: <CAOMZO5CT=1sSG1WLWprN6O3_puzifv9j0uG7EdXUMpXU3xcdYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
To: Rob Herring <robh@kernel.org>
Cc: heiko@sntech.de, broonie@kernel.org, krzk+dt@kernel.org, 
	linux-spi@vger.kernel.org, conor+dt@kernel.org, 
	otavio.salvador@ossystems.com.br, Conor Dooley <conor.dooley@microchip.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:07=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> $ make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
> /home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
> display@0: Unevaluated properties are not allowed ('spi-cpha',
> 'spi-cpol' were unexpected)
> from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>
> Any suggestions?

'spi-cpha' and 'spi-cpol' are not documented in spi-peripheral-props.yaml.

I can send a patch adding them to spi-peripheral-props.yaml.

