Return-Path: <linux-spi+bounces-4446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF3964E6F
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 21:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D701F21AC0
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CE1B654D;
	Thu, 29 Aug 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8oZDa1N"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E241465AB;
	Thu, 29 Aug 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958464; cv=none; b=H8QoD7KPouln3XUWDbkY5o7EkqeUFS2XW5HoigTWAHamlToSR1GuNtAZGryxO/X9QbyAjLI9Icui1Zobp3B6a2RQdZIs8nqGqpizU6206gdg8mvkHCWg88yLkXEbxcOwDM55kg8yGkVC8nrs5AQSF1pJLewWh+m1J8oub+f0iNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958464; c=relaxed/simple;
	bh=7GLr8yIVNUtXr0fAQM9DZ2ARJRFJE2UtRt1ZrYnrcto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu3fdeUsUsoXKod6I0aFFFSIgQeCFiYmbyHrQvOrTSaE7iFcQf7EW4+H9roADsIeRp/diFLdkmXYZ+Srtsfou3Cxuc6btDXs0IXQbguOmpmT2y6yhkEoLJFI3sIOPTNDHJnUWKgARq+Lou4A1vZqFC+wTUZJ4k+MZlVYBzKuxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8oZDa1N; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533de5a88f8so1012054e87.3;
        Thu, 29 Aug 2024 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724958461; x=1725563261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO5QKMFkQGARdNAhLEkb/pyGNB1/CKbDelDoQf4PNG0=;
        b=L8oZDa1NvVKBDXv1bRrkolZyffgsC1AywlLUS0HjKj+giHhw+9vTgE2VZmExmC5cSu
         Cf4a0zz21OwPOz/afh0pItQDDrOOjbN7ypxCjQSw9WD4xW7edxb0E6z8pMkA+CMty/6E
         ff/g81QhymlFtF9oPL6H3aOOmEhMYzXgDItBswpv9AW1hJq05RT1qdx0c5fChd4P2IJK
         ih+o5qW1ltmt242pL2ZGLTv/Dcd4DGXwYkiKz5DA47g8GummDwl2a7qrztIbLIF5rCP6
         9ZvEdgtGdtiOfUg2OiY3UO8tearQqVKxfVsOMZD2pgfDJgQr+OpgypCoDDRx5nftdjGc
         yUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958461; x=1725563261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO5QKMFkQGARdNAhLEkb/pyGNB1/CKbDelDoQf4PNG0=;
        b=O6PXZ3t1a43HDvM9SNxPCR3rLStu7X84chCFov3J6OPPZI/M8hp+P82KC1RYCzU2gL
         hdfPWo1SqVvKegHRlv2fmlOPPk+y2bZzABrFFI0NXaS37tTTjo2718k3VJ5AxltCgQtW
         e4mHfOnFs8XzCeZjbkY+pvQdxFByV7aiRxR+JlVbb7D4L+IH49CifyX3Za8MlGxNKQzG
         ShbyIXEyHnAPL7DHaJAIOTFX+/4axi4Mlxu8eQObemXFjus/oKL+duXMj3foyKLMUVaJ
         gT+luco87xcdHk8BC+09mfNJQzBAfy7qcVEAx/+0Ed4PYa/BYsU2tJZjr0iX7EAIj0Fz
         GLLg==
X-Forwarded-Encrypted: i=1; AJvYcCWsuflLlQCX3ORVN4ridHuS+irA32NLh2r+BBSqhc8+1l4LqWS+FRGOlJvA2V0gwgkgofrwBRN40wtg@vger.kernel.org, AJvYcCWxV4jI9m9kjgs7njbpwiI5tcFYPReBRDPikbXvIHAGjseyHa8Y3+ND93gLppOWnF+r/20olFE/6g9m@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBttut5is/AonVTzGp6kzyfBZ/5zpiYuohEAVq/UF4HEDpf/s
	kZ4DtFTRZhNHZwzDK7lVk5SZrhFzH1as96EzPdIQ5xol0Kd+xxnUabYVkDdHJ7gvWrzGoSlZqYJ
	L7PYnwIQnv4tBiwlwcflpoLEjHOc=
X-Google-Smtp-Source: AGHT+IH+2SifOAvpl4+hv4MuP7AodrgFtL2Z5nNZdIWU4TbOefhzNyxQwOURMOXT4Z0T33GKFBx3C2CRHBq40pPOIiw=
X-Received: by 2002:a05:6512:b0e:b0:52e:be1f:bf7f with SMTP id
 2adb3069b0e04-5353e57afa6mr2356824e87.27.1724958460170; Thu, 29 Aug 2024
 12:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829113158.3324928-1-festevam@gmail.com> <172495658983.899923.10430034751474903183.robh@kernel.org>
 <CAL_JsqL7+5q=7rag4UqfHUR96ii-j8vDksRj2xWnWs=Y_FWU7A@mail.gmail.com>
In-Reply-To: <CAL_JsqL7+5q=7rag4UqfHUR96ii-j8vDksRj2xWnWs=Y_FWU7A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Aug 2024 16:07:28 -0300
Message-ID: <CAOMZO5DVnwrLcswA2sV0EfQwLJx343B2Fq76boPzfKExu1u1qQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
To: Rob Herring <robh@kernel.org>
Cc: heiko@sntech.de, broonie@kernel.org, krzk+dt@kernel.org, 
	linux-spi@vger.kernel.org, conor+dt@kernel.org, 
	otavio.salvador@ossystems.com.br, Conor Dooley <conor.dooley@microchip.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, Aug 29, 2024 at 3:43=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> > New warnings running 'make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb'=
 for 20240829113158.3324928-1-festevam@gmail.com:
> >
> > arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: display@0: 'spi-cpha', =
'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
> >         from schema $id: http://devicetree.org/schemas/trivial-devices.=
yaml#
>
> I'd be okay if trivial-devices.yaml references spi-peripheral-props.yaml.

This is what I tried:

--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -424,6 +424,9 @@ required:
   - compatible
   - reg

-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false

but still get:

$ make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
/home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
display@0: Unevaluated properties are not allowed ('spi-cpha',
'spi-cpol' were unexpected)
from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

Any suggestions?

