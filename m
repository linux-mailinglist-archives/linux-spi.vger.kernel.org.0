Return-Path: <linux-spi+bounces-7591-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682BA89524
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 09:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749053BABE6
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164EA27A124;
	Tue, 15 Apr 2025 07:31:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95224A043;
	Tue, 15 Apr 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702272; cv=none; b=W5RvCGZJYahOX/3zfOd9ozguYrx71Lg53mNJ5B234LjOU14/J/Hwj3ZSmaZ2NAuRrPlBQfoSyeRCVRKE8qmJWA7wKWjjZ1gnMPxoCk2UvXnrpeWTNn2hmkYdsMifE4H/b949XselwqIIqRNcC2rwdG1s/kcXAksAKtZZqut0IvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702272; c=relaxed/simple;
	bh=VTZCWyCGjdciP3aZHJhTk6E9mLATfcs0U4wCy0CbtGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOVPlTo1bUfePfTbzCjra6EgMadFcTcnQ4xjNYqtgJlLoV189ezLp/pStyaTQy1sGEVYxMPzxFUMVBpIlz7FdedrFUEvXwCNT4J4hnry1aIdbVUS3Hnnxkm/+yjT9+ZGmtw36XZNHTYdETwQjLqzrI3g4PLm69Mr46LH5V4DMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-525b44ec88aso2451048e0c.3;
        Tue, 15 Apr 2025 00:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702268; x=1745307068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGw5spwHw8NIdX95wcfYNhGWI1R6yaJkvthw0sRY1HE=;
        b=wfWH+/Ztq0+3RycVU5UAFi8QA6R8FTLU7+3NHy67IlPbHiGjFT69phqdFtRdGeDaiH
         FmtiofoyiWgSDChubPEpBfVBdXAAXcAjRUkwG9qrasvJ6jq53Cum55LCpkFdkw6KcKJv
         yZeYye8mYW61CMzIyB/l6xHdY/gjV+TglM/8VraqetS0Cjt1FyzwAmdBqipGhzwzIi0f
         HsWRgfSdprc4YkWxZWnGFa1E36j3aRYAfsaS37iHCjE60p9l6JuQF15x3b2OvU7WEiMO
         PMJ9HURFt8dA9R+UoxakW7lX8KRM88mp+WCKN1ZEebjLerfiediqm4LNddXWvPZdNd8/
         peyA==
X-Forwarded-Encrypted: i=1; AJvYcCWUIVmgNjd9sj833wLF+YXftJFzpOnsxEW8L4CCukRmZZtgjzmOmDvlaacBXTD4nZe1y0PB8gzCQBxDCP8=@vger.kernel.org, AJvYcCWVrg7bv97ANX2smnQdvTAWbB3s6vJjJEX5JhAUQPKcarw89jgOG2IxuU7Npa1HJNHg/v/N78C56QR6AYc7QSzpP6A=@vger.kernel.org, AJvYcCX/df+EwSDeCOkYR9bGirwwlmR9jZ3K0wz6j3/VLpjbexwZ+3lakIZo33rFCUJa6MR7G27BmIS6bde9@vger.kernel.org, AJvYcCXHBvdcxFM+iKcVYW4jkKdmxrqQz0Cbz1Fl0YJ90VitxU6QmZ4TStPKF5fEdTOAJRUyWJaZIBcdk/wH@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfw5uh9/luy46Mwweji+Jb9Qov6hwrcTSN6eFQeqpTJlggAS8
	3zQLmZx1BQu/gUtW7xR68UMqvRPyc/yPjbRnJ3G9098mb+u8gzMWsKud1YrY
X-Gm-Gg: ASbGncsoaXgKh/CFXqyacG51xmWO5cW4Luw9US/tuNzV610JCJ5s/fTRHs8H8EkrVDV
	GTSEVlFiaq77itEIvJhkPiT4XWR2j4WLZAmxCfibj1qpjWh1RRz3T3lINBaJt+2VlgYWzWJ97og
	42m2qtmvWkyLesyUwhiIHoIwuPZeXcs+pn4+zXHCxskgjfRDUDjgvq4dbZaEEpzqi4G8DP91zA7
	kzDJ6TG3vselpVjqTQKn9HKkCo0sJlDVokoRgsTzk3KzcB1qNRdL8R2VAARlehbrq6g03XOdjLg
	lGImqxnQQFKGoQ9QYsvwdRzyTZRyVl+3cPO9tnoE0KIIvofES1bD9aecmu6ML//SocfI0Iw+RJh
	fjI7/7vkZ/XxdDme5DA==
X-Google-Smtp-Source: AGHT+IGbEYFoAWecDGlS6CiSHgeDQgxz+wOiqMKSXznm3SEV7fRlVBWhHmmjN54WUunr0GsfRHQKJQ==
X-Received: by 2002:a05:6122:512:b0:520:5a87:66eb with SMTP id 71dfb90a1353d-527c34956f9mr10680173e0c.3.1744702268541;
        Tue, 15 Apr 2025 00:31:08 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-875560e3077sm2577525241.2.2025.04.15.00.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 00:31:08 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5241abb9761so2202769e0c.1;
        Tue, 15 Apr 2025 00:31:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg1GzQrvuZ//+2HhdKKWxBryRD7EBjkhJv+KOXKDZJRx2LC83u7bqIahpbuAcS4LLsiEUHbbxfFecYDho=@vger.kernel.org, AJvYcCVa0aazrxUgnU8YhCaORduQOKfQNeckF1jdZumicBE/9UYgafKQq785W1GzT1KRbdkEZkc+m9cloAF0@vger.kernel.org, AJvYcCWnA0ahEC9P/ss9bqCPDtcmTJtRx6GEpDe9UueBXBKquvmsKxzJgGoDxc4hJx70rkx4EdNrUFJGdXapR+flKsSIFZs=@vger.kernel.org, AJvYcCXl5ZaZplbqEgA//FLrsYw+QAIi1clZXNqsoolXFVzJYWu6kIEMarGHaRAQJxNCCIk53/TOZXsJOkqR@vger.kernel.org
X-Received: by 2002:a05:6122:8282:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-527c35c2351mr10043766e0c.9.1744702268047; Tue, 15 Apr 2025
 00:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com> <87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2025 09:30:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
X-Gm-Features: ATxdqUGJna7AxHia-Op7KClT4HpJfHRHVf9wGRzfALZvGSP0kVUzM1m0vvE3Efc
Message-ID: <CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S
 Sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Tue, 15 Apr 2025 at 03:33, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> uses Of-Graph in DT.
>
> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.
>
> Adds schema for MSIOF-I2S (= Sound).
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for the update!

> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -4,14 +4,11 @@
>  $id: http://devicetree.org/schemas/spi/renesas,sh-msiof.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Renesas MSIOF SPI controller
> +title: Renesas MSIOF SPI / I2S controller
>
>  maintainers:
>    - Geert Uytterhoeven <geert+renesas@glider.be>
>
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -146,24 +143,38 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 64
>
> +  # for MSIOF-I2S
> +  port:
> +    $ref: ../sound/audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
>    - power-domains
> -  - '#address-cells'
> -  - '#size-cells'
> -
> -if:
> -  not:
> -    properties:
> -      compatible:
> -        contains:
> -          const: renesas,sh-mobile-msiof
> -then:
> -  required:
> -    - resets
> +
> +allOf:
> +  # additional "required""
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: renesas,sh-mobile-msiof
> +    then:
> +      required:
> +        - resets
> +
> +  # "MSIOF-SPI" specific
> +  - if:
> +      properties:
> +        $nodename:
> +          pattern: '^spi@'

This condition does not match what you wrote in the cover letter:
the controller is used in I2S mode when a port(s) subnode is present,
and in SPI mode when no port(s) subnode is present.

> +    then:
> +      allOf:
> +        - $ref: spi-controller.yaml#

Documentation/devicetree/bindings/spi/spi-controller.yaml indeed
requires that the node-name matches "^spi(@.*|-([0-9]|[1-9][0-9]+))?$".
The controller's node is located in the SoC-specific .dtsi, where its
intended use case is not yet known, and its node name cannot easily be
overridden in the board .dts that specifies the use case.  Hence the
node name must always be "spi" (and cannot be e.g. "serial-engine").
Let's hope there is no other use case for MSIOF that requires using
a different node name...

>
>  unevaluatedProperties: false

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

