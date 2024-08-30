Return-Path: <linux-spi+bounces-4480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F094E9668AD
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A71F21053
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9821BB688;
	Fri, 30 Aug 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP9Dm6FE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814831B3B0B;
	Fri, 30 Aug 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041111; cv=none; b=tT57PLJDSzNAPJNWex4A0ArCZMEcftPI/FE70HLvTuQ/WU7M7McjOPASTdTA1StumiHDOA2O9ED3mtPbq2PQuQ4m1ZDDAmE7Tb676nc4lqEBpMCZrJMtD9yu7n3WbIVKBYiDNwnUtk13qeQvC99iNqm5BkidBZXh7IwBsK4EvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041111; c=relaxed/simple;
	bh=5zCcseGgAQsWFWzSxH/LG13rTYVwh1PQugqe7G42R3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qV37X8fZAzu7/LdYDL7SffFUM0Tgm6OLnG3IiCGxkbN+lA9zS5gxPC9ZndQT01jisXwvtgvCHp5Zt1g5G4HCved/JGheJQhpzWXIVqFY0dGspD6iOQIEFx47oQUlSLzQlVpxLcWk7ex4Wat9BO6uVSU/lV8xYfFX/IRuNCzQlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP9Dm6FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C992AC4CEC2;
	Fri, 30 Aug 2024 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725041111;
	bh=5zCcseGgAQsWFWzSxH/LG13rTYVwh1PQugqe7G42R3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qP9Dm6FEQPmlI+S6Tgya29krfv0VrR52xgbMT45ncn5Thq0SuwVLj4uXF5kJCgFrF
	 GLaCj4sLVqQaSLZfS6eSGV5gkDPcZF/0nYVyZiIPYr+Q/D/85kwRMkdjX4DqlJq470
	 f44DRYzMfT/0OH9SelSdBRj77frx9hLr2VkWDLkX2k0KCDSr6MaRWNWpCCNOeeFPgb
	 dxgXZfIMNNLa1+vP3npUXXtA6Doqe/zwlfTaA3ZnUInfdPV2oOGids46d4TYZrKHKN
	 eP9P8dw1MI7e+1SWVnYj2G+H1vYvTKPma3bfRp6FioGfPZRLPG2M5tBfnUaJ0wMtFH
	 zqwwb7RFNJeGg==
Date: Fri, 30 Aug 2024 13:05:09 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org,
	linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
	heiko@sntech.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to
 spi-peripheral-props.yaml
Message-ID: <20240830180509.GA565970-robh@kernel.org>
References: <20240829201315.3412759-1-festevam@gmail.com>
 <20240829201315.3412759-2-festevam@gmail.com>
 <20240830-anchor-glucose-f8dcc1b0fd16@spud>
 <CAOMZO5AAyjq2M09Ynbu57jd_RyDe_5fN4oaoxMv1CeKjo2aG5Q@mail.gmail.com>
 <20240830-rockfish-shun-da3e42b69f1d@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830-rockfish-shun-da3e42b69f1d@spud>

On Fri, Aug 30, 2024 at 04:17:02PM +0100, Conor Dooley wrote:
> On Fri, Aug 30, 2024 at 12:05:20PM -0300, Fabio Estevam wrote:
> > Hi Conor,
> > 
> > On Fri, Aug 30, 2024 at 11:14 AM Conor Dooley <conor@kernel.org> wrote:
> > 
> > > Since those don't come from spi-peripheral-props, not really the correct
> > > justification (although why they don't, I'm not sure). If you still saw
> > > dtbs_check complaints after the first patch, I maybe the controller
> > > schema is missing a reference to spi-controller.yaml?
> > 
> > I changed the first patch as suggested:
> > 
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -29,6 +29,10 @@ properties:
> >      description:
> >        Chip select used by the device.
> > 
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> > +
> >    spi-cs-high:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> > 
> > spi-rockchip.yaml does reference spi-controller.yaml, but I still get
> > dtbs_check complaints after the first patch.
> > 
> > $ make CHECK_DTBS=y rockchip/rv1108-elgin-r1.dtb -j12
> >   UPD     include/config/kernel.release
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
> > /home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
> > display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes:
> > 'pinctrl-[0-9]+'
> > from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > 
> > I would appreciate some suggestions on how to fix this warning.
> 
> Ah, I think I suggested something garbage, because I misread the diff,
> as my quoted mail evidences. I was really trying to suggest putting
> spi-cpha: true
> spi-cpol: true
> in trivial-devices.yaml, but I didn't notice that the patch was to
> spi-peripheral-props rather than trivial-devices. These properties are
> defined (for reasons I don't quite understand) in spi-controller.yaml
> and applied to children of the controller node by that binding and I
> wanted to avoid the redefinition.

I steered Fabio wrong...

I think we originally had these in spi-peripheral-props, but then 
decided they are properties of the device, not the controller. These 
properties should really only be needed if the device supports different 
modes. If what a device supports is fixed, then that can be implicit.

There's one other case I see with "dh,dhcom-board". So I guess add 
spi-cpha and spi-cpol directly to trivial-devices.yaml.

Rob

