Return-Path: <linux-spi+bounces-5726-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347F9D1294
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 15:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8CFB2D86C
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6B192B79;
	Mon, 18 Nov 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kg3o6mNG"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033D195FD1;
	Mon, 18 Nov 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937178; cv=none; b=lZ+PPFTn8Cbvfh60QzvWrsD0Hq5RlXiMoK9+ll0KsLcPi4eW29Eku9M5yHCoHzrL05cxLEX2DlVkOeJa2eJxDiaF4lkVxo9SHghBkOECCti365YhiLSNynzvLWODCX0I1yWHr+LpbY/FKyVv3WYefyji20xJcW39Lq4UHjjHfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937178; c=relaxed/simple;
	bh=1dzIu+bDS3mEQECtESSifdxh9boBbAqXLDWb6o78W1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTidoQs9xegjiB00u3y+EI3+dO+pt9D8T0zHGrq9cw9IxWDJODk/6SSLP4VSVUpHiTHPYVTBCFLTA0+mYzwml38/DMi/Iv66K+Fuwf+sgyHM/KeLXf1T5yDpEENcHdf0qu+nEJaEx5v/6/zxh6la35jMw1cR5IbrzfR2QkzgDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kg3o6mNG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB8351BF208;
	Mon, 18 Nov 2024 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731937174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKBfmWwe0K8YK6G59KsdbaDz2+vE4JtCifokD5Jr7zc=;
	b=kg3o6mNGQfhtXlBOIcFMtnFqK7OJJG4S/uA++2tR7IMdOehPRj+qTUkcxNKZsF0cG/F2tl
	0ZgptP2PYC9FDYJwuWbteP+AZysqliZ5AjXxkJCmIgsRapeZgllNAdrIMyv9zvYXlwzrRx
	ZqV098zadeIDwrUDGNzQUrlE4xBplfMZD43XGUbtqou3is7C9EK0RaSZhQXtjbCbxLyl80
	9aEGY3YDkivEu5QHWUCM9NWfy8H6dVznjYMubOhNE5+h3OOltp9KVebf4/O6lkzkqvisQ/
	Ywr8UohM5O+ut7DpWgSA96aAkUNb0IorayZKgQZrcFnPpicVpPrZE1EBBPPBlg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: <tudor.ambarus@linaro.org>,  <michael@walle.cc>,  <broonie@kernel.org>,
  <pratyush@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <robh@kernel.org>,  <conor+dt@kernel.org>,  <krzk+dt@kernel.org>,
  <venkatesh.abbarapu@amd.com>,  <linux-spi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <nicolas.ferre@microchip.com>,  <alexandre.belloni@bootlin.com>,
  <claudiu.beznea@tuxon.dev>,  <michal.simek@amd.com>,
  <linux-arm-kernel@lists.infradead.org>,  <alsa-devel@alsa-project.org>,
  <patches@opensource.cirrus.com>,  <git@amd.com>,
  <amitrkcian2002@gmail.com>,  <beanhuo@micron.com>
Subject: Re: [RFC PATCH 2/2] dt-bindings: spi: Update stacked and parallel
 bindings
In-Reply-To: <20241026075347.580858-3-amit.kumar-mahapatra@amd.com> (Amit
	Kumar Mahapatra's message of "Sat, 26 Oct 2024 13:23:47 +0530")
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-3-amit.kumar-mahapatra@amd.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 14:39:32 +0100
Message-ID: <87y11gwtij.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Amit,

On 26/10/2024 at 13:23:47 +0530, Amit Kumar Mahapatra <amit.kumar-mahapatra=
@amd.com> wrote:

> For implementing the proposed solution the current 'stacked-memories' &
> 'parallel-memories' bindings need to be updated as follow.
>
> stacked-memories binding changes:
> - Each flash will have its own flash node. This approach allows flashes of
>   different makes and sizes to be stacked together, as each flash will be
>   probed individually.
> - Each of the flash node will have its own =E2=80=9Creg=E2=80=9D property=
 that will contain
>   its physical CS.
> - Remove the size information from the bindings as it can be retrived
>   drirectly from the flash.
> - The stacked-memories DT bindings will contain the phandles of the flash
>   nodes connected in stacked mode.
>
> The new layer will update the mtd->size and other mtd_info parameters aft=
er
> both the flashes are probed and will call mtd_device_register with the
> combined information.
>
> spi@0 {
>         ...
>         flash@0 {
>                 compatible =3D "jedec,spi-nor"
>                 reg =3D <0x00>;
>                 stacked-memories =3D <&flash@0 &flash@1>;
>                 spi-max-frequency =3D <50000000>;
>                 ...
>                         partitions {
>                         compatible =3D "fixed-partitions";
>                                 concat-partition =3D <&flash0_partition &=
flash1_partition>;
>                                 flash0_partition: partition@0 {
>                                         label =3D "part0_0";
>                                         reg =3D <0x0 0x800000>;
>                                 }
>                         }
>         }
>         flash@1 {
>                 compatible =3D "jedec,spi-nor"
>                 reg =3D <0x01>;
>                 stacked-memories =3D <&flash@0 &flash@1>;
>                 spi-max-frequency =3D <50000000>;
>                 ...
>                         partitions {

Same comment as before here.

>                         compatible =3D "fixed-partitions";
>                                 concat-partition =3D <&flash0_partition &=
flash1_partition>;
>                                 flash1_partition: partition@0 {
>                                         label =3D "part0_1";
>                                         reg =3D <0x0 0x800000>;
>                                 }
>                         }
>         }
>
> }
>
> parallel-memories binding changes:
> - Remove the size information from the bindings and change the type to
>   boolen.
> - Each flash connected in parallel mode should be identical and will have
>   one flash node for both the flash devices.
> - The =E2=80=9Creg=E2=80=9D prop will contain the physical CS number for =
both the connected
>   flashes.
>
> The new layer will double the mtd-> size and register it with the mtd
> layer.

Not so sure about that, you'll need a new mtd device to capture the
whole device. But this is implementation related, not relevant for
binding.

>
> spi@1 {
>         ...
>         flash@3 {
>                 compatible =3D "jedec,spi-nor"
>                 reg =3D <0x00 0x01>;
>                 paralle-memories ;

Please fix the typos and the spacing (same above).

>                 spi-max-frequency =3D <50000000>;
>                 ...
>                         partitions {
>                         compatible =3D "fixed-partitions";
>                                 flash0_partition: partition@0 {
>                                         label =3D "part0_0";
>                                         reg =3D <0x0 0x800000>;
>                                 }
>                         }
>         }
> }
>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  .../bindings/spi/spi-controller.yaml          | 23 +++++++++++++++++--
>  .../bindings/spi/spi-peripheral-props.yaml    |  9 +++-----
>  2 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/=
Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 093150c0cb87..2d300f98dd72 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -185,7 +185,26 @@ examples:
>          flash@2 {
>              compatible =3D "jedec,spi-nor";
>              spi-max-frequency =3D <50000000>;
> -            reg =3D <2>, <3>;
> -            stacked-memories =3D /bits/ 64 <0x10000000 0x10000000>;
> +            reg =3D <2>;
> +            stacked-memories =3D <&flash0 &flash1>;
>          };

I'm sorry but this is not what you've talked about in this series.
Either you have flash0 and flash1 and use the stacked-memories property
in both of them (which is what you described) or you create a third
virtual device which points to two other flashes. This example allows
for an easier use of the partitions mechanism on top of a virtual mtd
device but, heh, you're now describing a virtual mtd device, which is
not a physical device as it "should" be.

Thanks,
Miqu=C3=A8l

