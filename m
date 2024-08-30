Return-Path: <linux-spi+bounces-4473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BE49664F6
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 17:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29C61F24B8B
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA151B4C2D;
	Fri, 30 Aug 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht7PmoMb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2B1B3B2D;
	Fri, 30 Aug 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030337; cv=none; b=KfLOgJrxpOK0xV5QpuAkzm0m3ryG+j5RLytGPx/BNBe9bd7VUzZ9siR9UMdYZ2Nfk5lZ02Tx6EMaumQkNw7kD6hHWnqYFBanKbt4q2jzbcOlPKRWhG/PxGqDoYTRVDSh3qKpLlPprZGjDknXc4i/NonJBDha0tWkMoFVlYLwd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030337; c=relaxed/simple;
	bh=wGjDLiVwN6M6gPX/q0yP9flSRyJMn6wvHbCanhi3VJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snOiAemlgpbUOu1T+ADyB6/VhERV7Ocgq7vsMGGMhOOayYFiDlnTw68ckjZ+KkUu2ItV9cjrcVzN0drhBmn58dezIeN1GjNlaN53BusdqkhcrFqM6O/D2Z8fWgeIdORHl7OWPoohnSYcJbq5VfPTWQB+O79cPtO0qjkh/GuNgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht7PmoMb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5353cd18c20so2376952e87.0;
        Fri, 30 Aug 2024 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725030334; x=1725635134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ireDvuHVsozyU3taGw14ueQbQUF90HsxC8GVI542I9g=;
        b=Ht7PmoMbczgNITWIdxK9v0S+B/ATBfE407RrdLmXcXvmsCWVBT5HsyUaVk9Z6APGYY
         QD27feC2b+s8qIXcL38ffsW6wo3rFIbzMzP9LHtVJWkC1a+A6rSO9pcLGCWOkRl7yXfJ
         4rabG7TyZcKRJ46N8SBxulTPc/chXLMHvNnAlcaL/cJH6q8W7dyqeVTEgsY8oIZiKfpx
         ehmmIkz1WPI02lxxyUmGsy16uANU71aDr5IqvQPZnH8/qeSLVchI2xAdDGisnsQj7efo
         NYIe4aJPWzMB64TnbRMZ6+qlW86J/FO5qioG38G0oj7SR426B8sPbY53vauIg/sZlrh9
         emhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030334; x=1725635134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ireDvuHVsozyU3taGw14ueQbQUF90HsxC8GVI542I9g=;
        b=dtzS57UT6bbLWzsqUIT8Q1TPlxL1d27aevxliiEx1q4jUPekmWpdP1r74z+JgXW7hU
         JeOcqHGk5lDvKi51fZAo4ZgzZgclqewRbfgXH/SKD9QIdQ+qdBSS7GSzcKhGHfNJ3oon
         Zy7DUREi0698uiElOQlr1AKOFh3+c0aIwMK0hJALVgNlRH9Xw0P2XM7Y5qyPYZdJQ3mw
         ysPclhXvnajhKbmmM3vfbpolL9VlcoFlHz8qPHvKFp2ME8BaZgPEDkrlN6FZoAXISEK7
         XQf6Y/v34ehOdmEQC1v+fii02Ghm88vagwdBz+LJDMIpAbb6YJOEmoUMLacCuIRLR7iH
         iHpw==
X-Forwarded-Encrypted: i=1; AJvYcCVhabUl1mlcyYvCP4UUmPzbZpm06SLXIIATUV7mAj1GUtkf2YtXx9WsJ+hk5tg3bhhp2ru4hiy+NOCK@vger.kernel.org, AJvYcCXl1un0cKO91qvWOXPY1X2fqdWGWaro9ugAiHpoML8ojB5rHr8hwlAdzfbF6DtXPVHFU/byRiHOcYyB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xV+6594sgOtnb7UV3+gu/v4fbizSagXaWUvfV0xtzPuAEaow
	Crn3DCQ3KVj8F4ec4v/odvB+FlTSmOh+3ucahlc/gRF2d/3qbhTaOQVKMyjUFW/NWOgrWHGgR20
	9WmsCdr9rtFUrjx3gBK2SpJbdMQc=
X-Google-Smtp-Source: AGHT+IHBPbeu15lHYGY3WPxj+lRuX2AuRCKP963v0C40uyirFm8K/blphkt/QPAcUhOHkj1uSGmS0pqb78ZBXhIyZDI=
X-Received: by 2002:a05:6512:b94:b0:535:3dfb:a4fc with SMTP id
 2adb3069b0e04-53546b0548dmr2178458e87.22.1725030332018; Fri, 30 Aug 2024
 08:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829201315.3412759-1-festevam@gmail.com> <20240829201315.3412759-2-festevam@gmail.com>
 <20240830-anchor-glucose-f8dcc1b0fd16@spud>
In-Reply-To: <20240830-anchor-glucose-f8dcc1b0fd16@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 Aug 2024 12:05:20 -0300
Message-ID: <CAOMZO5AAyjq2M09Ynbu57jd_RyDe_5fN4oaoxMv1CeKjo2aG5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to spi-peripheral-props.yaml
To: Conor Dooley <conor@kernel.org>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Fri, Aug 30, 2024 at 11:14=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:

> Since those don't come from spi-peripheral-props, not really the correct
> justification (although why they don't, I'm not sure). If you still saw
> dtbs_check complaints after the first patch, I maybe the controller
> schema is missing a reference to spi-controller.yaml?

I changed the first patch as suggested:

--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -29,6 +29,10 @@ properties:
     description:
       Chip select used by the device.

+  spi-cpha: true
+
+  spi-cpol: true
+
   spi-cs-high:
     $ref: /schemas/types.yaml#/definitions/flag
     description:

spi-rockchip.yaml does reference spi-controller.yaml, but I still get
dtbs_check complaints after the first patch.

$ make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb -j12
  UPD     include/config/kernel.release
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
/home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes:
'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

I would appreciate some suggestions on how to fix this warning.

Thanks

