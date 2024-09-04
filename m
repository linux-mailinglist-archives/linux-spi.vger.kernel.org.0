Return-Path: <linux-spi+bounces-4635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C882096C5BE
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 19:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A83C1F279C5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A3D1E00AF;
	Wed,  4 Sep 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqD5lzdC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E584778C;
	Wed,  4 Sep 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472204; cv=none; b=ZCb/S8v98QL/ZeMaYuWqbsz4fqTmnLUDh5FK2vc+bYAmpuYXE3RJtXrgvesSdZBQEuO3x0b+j1hvEH97D0waaAQofrd0/JfMjBSeAhOAZa4lmba/qaOwkAvSgfRjdmzRaP79YuQp32qCEROajKyaZlclSuPvzOaw/O+kvI69mPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472204; c=relaxed/simple;
	bh=hHxVrQSEsPsgYlnyrf6ReJTTCLd0pbkf38E+5RYV1og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTcLyOkJLpx+DUD4GxkVgLyp7MQ2w1l78fhigXEve0Ywp3pJ3QdLJ8Aue3+vN4EyAeQZF2t7BckJe0TA4GQSqngSuuh99hG45jnC0VQD/38AOphSkbzTCoY1zY8g0I1TCBaAxRPe4bagA9zIGV4aVaDSPMUJ8DjEDFoFicOBAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqD5lzdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0821DC4CEC5;
	Wed,  4 Sep 2024 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725472204;
	bh=hHxVrQSEsPsgYlnyrf6ReJTTCLd0pbkf38E+5RYV1og=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kqD5lzdCeou6euYUG/Awz9d8i6P9riIdPT9Aegf0Ci71RpgbcssQQ0bTxSpPEsl+J
	 mjupBVxbdjPOrjQL8yg8TE13FDM2+ZWMu8b/Ww9mcDcLNnjZ7THvhPNF0uYwh6Nimv
	 v9K8h3JkIVoFK1glwLDGN8QLYqEM9hK5kuMh2rC/KNAPuqbAfSZtT4CE9bAt+AUO5C
	 1hFEyslBw2VGEV9kIHXq/yjKuSKyX/dTnSqWRYRa48ZWsXF3sUACCgl1/xJhEPqhCo
	 ZNPDTH2QUNtoTkH0NpyF6vCF1UfWyexV06VEoqAvO4yHmaWO7M9ZgfP3gTMIuKr2xQ
	 7VBA3OjUenhSw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533488ffaf7so9529962e87.0;
        Wed, 04 Sep 2024 10:50:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5N9I3tOid8NbYICm3dbJiv/ww3J3V18h0nAQK/Vcz/rTAqg++v63/SHpUUka87U7lm3KMsDfPGMGB@vger.kernel.org, AJvYcCVjWhxqTWqzcOCQHmgdiKARzjr218EFHWVgjlj0l9VnOca/1do63mWBcu/dSoSE2sLDUv2xYFTiczWi@vger.kernel.org, AJvYcCWZ04S+Zob4BQp3tbKK1H8nKW+E9AXR0c/3pZk8VaH/MSdroMM0O0u71KhG+UaxV6XGzXzkAgjq8EzOgID6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+s6IW6VkVE68sY2nCPzDt5+vO1US1net6nxUg0VxTa8fHVF9H
	Y+14RcLBOfVSfr4RLN5Avz/GwuHWj3ZydbPZUQonTsAXSqvpD4LO9uCwnKWxu9u+mEd411NhxSp
	dGbzTQTxR1JsREqdabweR9dpDRw==
X-Google-Smtp-Source: AGHT+IGSQCWllSjVNUht9/hBiRn31t2hIqomRO4roXkiMDVa92ly9RGxw/tcqHJN+GBOFtCZbBxj7IpMjDy0TIfTxaU=
X-Received: by 2002:a05:6512:2521:b0:533:41ec:bff1 with SMTP id
 2adb3069b0e04-53546bb3d58mr14192203e87.52.1725472202353; Wed, 04 Sep 2024
 10:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org> <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
 <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org> <e2558820-f36f-406d-8f83-95c7188c0ce3@beagleboard.org>
 <CAL_Jsq+6ruu23UrwJ=NUUrh-9R_E5tKREv1AyU24op_uUigpNg@mail.gmail.com> <2d3fd95f-6f4d-49d9-a473-b4c5631a4fee@beagleboard.org>
In-Reply-To: <2d3fd95f-6f4d-49d9-a473-b4c5631a4fee@beagleboard.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Sep 2024 12:49:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEfBGQsJw6Vn2FnCrMOEmwhTq9ro2Qca7bBAM_UKZ6-g@mail.gmail.com>
Message-ID: <CAL_JsqLEfBGQsJw6Vn2FnCrMOEmwhTq9ro2Qca7bBAM_UKZ6-g@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
To: Ayush Singh <ayush@beagleboard.org>
Cc: Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Vaishnav M A <vaishnav@beagleboard.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 12:09=E2=80=AFPM Ayush Singh <ayush@beagleboard.org>=
 wrote:
>
> >> gpio-map is what you are looking for. It's documented in the DT spec.
> >> It was created exactly for this purpose of remapping GPIO lines on a
> >> connector.
> >>
> >> Rob
>
>
> Hi. I found docs on nexus nodes [1] and tried using it for mikroBUS, but
> it does not seem to be working. Here is my connector:
>
> ```
>
>      mikrobus_gpio0: mikrobus-gpio0 {
>          #gpio-cells =3D <2>;
>          gpio-map =3D
>          <0 0 &main_gpio1 11 0>, <1 0 &main_gpio1 9 0>,
>          <2 0 &main_gpio1 24 0>, <3 0 &main_gpio1 25 0>,
>          <4 0 &main_gpio1 22 0>, <5 0 &main_gpio1 23 0>,
>          <6 0 &main_gpio1 7 0>, <7 0 &main_gpio1 8 0>,
>          <8 0 &main_gpio1 14 0>, <9 0 &main_gpio1 13 0>,
>          <10 0 &main_gpio1 12 0>, <11 0 &main_gpio1 10 0>;
>          gpio-map-mask =3D <0xf 0x0>;
>          gpio-map-pass-thru =3D <0x0 0x1>;
>      };
>
> ...
>
> &main_uart5 {
>      status =3D "okay";
>      pinctrl-names =3D "default";
>      pinctrl-0 =3D <&mikrobus_uart_pins_default>;
>
>      gnss {
>          compatible =3D "u-blox,neo-8";
>          reset-gpios =3D <&mikrobus_gpio0 10 GPIO_ACTIVE_LOW>;
>      };
> };
>
> ```
>
>
> After some fdtdump, I can see that at least the dtc compiler does not
> seem to do the forwarding at dt compile time. Here is the dump:

dtc knows nothing about it.

> ```
>
> mikrobus-gpio0 {
>          #gpio-cells =3D <0x00000002>;
>          gpio-map =3D <0x00000000 0x00000000 0x00000025 0x0000000b
> 0x00000000 0x00000001 0x00000000 0x00000025 0x00000009 0x00000000
> 0x00000002 0x00000000 0x00000025 0x00000018 0x00000000 0x00000003
> 0x00000000 0x00000025 0x00000019 0x00000000 0x00000004 0x00000000
> 0x00000025 0x00000016 0x00000000 0x00000005 0x00000000 0x00000025
> 0x00000017 0x00000000 0x00000006 0x00000000 0x00000025 0x00000007
> 0x00000000 0x00000007 0x00000000 0x00000025 0x00000008 0x00000000
> 0x00000008 0x00000000 0x00000025 0x0000000e 0x00000000 0x00000009
> 0x00000000 0x00000025 0x0000000d 0x00000000 0x0000000a 0x00000000
> 0x00000025 0x0000000c 0x00000000 0x0000000b 0x00000000 0x00000025
> 0x0000000a 0x00000000>;
>          gpio-map-mask =3D <0x0000000f 0x00000000>;
>          gpio-map-pass-thru =3D <0x00000000 0x00000001>;
>          phandle =3D <0x0000000e>;
>      };

You might need "gpio-controller" here. Though if you do, I think
that's a mistake in the kernel. It should work like interrupt-map and
generally you have either interrupt-controller or interrupt-map, but
not both (though that is allowed now too).

> ...
>
> serial@2850000 {
>              compatible =3D "ti,am64-uart", "ti,am654-uart";
>              reg =3D <0x00000000 0x02850000 0x00000000 0x00000100>;
>              interrupts =3D <0x00000000 0x000000b7 0x00000004>;
>              power-domains =3D <0x00000003 0x0000009c 0x00000001>;
>              clocks =3D <0x00000002 0x0000009c 0x00000000>;
>              clock-names =3D "fclk";
>              status =3D "okay";
>              pinctrl-names =3D "default";
>              pinctrl-0 =3D <0x0000000d>;
>              phandle =3D <0x00000081>;
>              gnss {
>                  compatible =3D "u-blox,neo-8";
>                  reset-gpios =3D <0x0000000e 0x0000000a 0x00000001>;
>              };
>   };
>
> ```
>
>
> So I am a bit unsure. Is the dtc parser in the kernel supposed to do the

No such thing as "dtc parser in the kernel".

> mapping, or is it supposed to be done by `dtc` at compile time?

No.

> Maybe we
> do not have support for it in upstream kernel yet?

Yes, there is upstream support. Grep for of_parse_phandle_with_args_map.

Rob

