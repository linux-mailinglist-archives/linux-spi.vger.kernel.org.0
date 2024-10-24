Return-Path: <linux-spi+bounces-5374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4EB9AEA0E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47A01F23551
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBC1E378A;
	Thu, 24 Oct 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6/MspT8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE91E766C;
	Thu, 24 Oct 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782844; cv=none; b=geD4icpDfgtf2k/ZMwEZegrzSWu3pWlpvpp11D9NH3v7yDJK6tT+2EAuMpITE9D8lpDrlRHRgOZbtRCQic2/av8MNjaZZjrkHLMNWD7xyCJIwpZEYADZjsBVWCZvJx85S/cNXVXIiMv20xFnbGDEt6YAaHMyQr3gnVkqlrGr0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782844; c=relaxed/simple;
	bh=SvIjThtAz+3hs0BLjpnwpREjkQ1yKHezPlmKnO8bpQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDUKKoA85P03bqqbQjZAyRjPJ0t5mCxxl27iGFAcRq3WnrHLsoI4jM2PVkvBS4zSTjSZ20yg9VZ7cSqSYdOlylohoqBK3Bb83Bw4t5Z2LwYGAowDqy2GsS2SnEC2BB4NTrK2lpmqJCzhX9OKwWM/hYECfs2i80YhbgGZlTgT7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6/MspT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD76C4CEE3;
	Thu, 24 Oct 2024 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782843;
	bh=SvIjThtAz+3hs0BLjpnwpREjkQ1yKHezPlmKnO8bpQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6/MspT8ZJ0LLZj+iNLOjKgo8wheWidUEy+VwJuRFZtDHLkZ0PFaaex/lolqsEWFf
	 /lEh5hGXtTNDLspunWrHzz9+0sYOXkJpG/1DEYIbGHz4M/ydkxvxB7zFgTEYZx3r8O
	 pbVxZnA2N8pP2zAHFT6XEUSpHhGmWGYZBAbjC+riZHbuj+x9LKXBNtx86OStRQoIPF
	 gPePp87I+9lQX4uGVCP5AKGZxu0z5LEXXibG0KCswUQgRvqn7ihP1umkvIk7js1CzM
	 5/0WjF23w5Kcv415AhGbg2VciNdlPiM4M3fwuIpyYjxx7yIicw3JYGtpsCT5W1Dq/W
	 XK0qkC9RySdpQ==
Date: Thu, 24 Oct 2024 10:14:02 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
Message-ID: <20241024151402.GA499355-robh@kernel.org>
References: <20241023120015.1049008-1-festevam@gmail.com>
 <20241023171739.475a2bb7@wsk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023171739.475a2bb7@wsk>

On Wed, Oct 23, 2024 at 05:17:39PM +0200, Lukasz Majewski wrote:
> Hi Fabio,
> 
> > From: Fabio Estevam <festevam@denx.de>
> > 
> > Add a lwn,bk4-spi.yaml binding for Liebherr's BK4 external SPI
> > controller.
> > 
> > Currently, the compatible string used for this device is "lwn,bk4",
> > which is the same as the board compatible string documented at
> > fsl.yaml.
> > 
> > This causes several dt-schema warnings:
> > 
> > make dtbs_check DT_SCHEMA_FILES=fsl.yaml
> > ...
> > 
> > ['lwn,bk4'] is too short
> > 'lwn,bk4' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
> > 'lwn,bk4' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
> > 'lwn,bk4' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
> > ...
> > 
> > Use a more specific "lwn,bk4-spi" compatible string for this
> > device.
> > 
> 
> Thanks for updating this.
> 
> BK4 is another example of to be long-time supported device... :-)

Does that mean we shouldn't be changing this compatible?

Rob

