Return-Path: <linux-spi+bounces-3640-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D391ADDF
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588F21C2112A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7819A2B4;
	Thu, 27 Jun 2024 17:21:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9419A2AB;
	Thu, 27 Jun 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508867; cv=none; b=KidvbIOAK5VSA4dtDbpQw2AAGQmSgFjWUpHSpFYNQUq0Wq9x/5b4XPgH9kQ2BHlQvygDY+mLJQ2wP/SNGRJZibEHe+Ynow3I8rQIl0N8HggBxGu7TB/nfYPuhBYQu7Y50yq9CNrXujgxABe36qtvVJox5Ak/WGsBPyFXPJuZf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508867; c=relaxed/simple;
	bh=P1QwJjtYvoyfwLx04MhNy1NVdqSnjvkpW2/5csHOcDU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=mTms4Tzrnn6kvXj1+DUoPPOQ8Yad8UM1XWR7LMmFCL1Oy5KAFhJr6buJzfsphEX+RplgQOExJkW4/lYn7j3m19MARgEFpU3Na1w+SxF5Cwwag9PtChVwpCQDoZ5rvNR/5fyasUw/8P5+MRSEOBEIv/UDlW3IXTHJJ58HeT4bTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 66B294CC;
	Thu, 27 Jun 2024 19:21:03 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Jun 2024 19:21:03 +0200
Message-Id: <D2AZ0QKTPY3B.1I48GLI90XD0P@kernel.org>
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Davis" <afd@ti.com>, "Ayush Singh" <ayush@beagleboard.org>,
 "Mark Brown" <broonie@kernel.org>, "Vaishnav M A"
 <vaishnav@beagleboard.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Derek Kiernan" <derek.kiernan@amd.com>, "Dragan Cvetic"
 <dragan.cvetic@amd.com>, "Arnd Bergmann" <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Nishanth Menon" <nm@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>,
 "Andrew Lunn" <andrew@lunn.ch>, <jkridner@beagleboard.org>,
 <robertcnelson@beagleboard.org>
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
X-Mailer: aerc 0.16.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org> <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org> <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>
In-Reply-To: <4e23ec81-b278-4f2b-815d-64ed9390ca55@ti.com>

On Thu Jun 27, 2024 at 7:07 PM CEST, Andrew Davis wrote:
> > +	mikrobus_boards {
> > +		thermo_click: thermo-click {
> > +			compatible =3D "maxim,max31855k", "mikrobus-spi";
>
> I might be missing something, but your solution cannot possibly be
> to list every click board that could be connected (all 1500+ of them)
> to every mikroBUS connector on every device's DT file..
>
> Each click board should have a single DTSO overlay file to describe the
> click board, one per click board total. And then that overlay should
> apply cleanly to any device that has a mikroBUS interface.
>
> Which means you have not completely solved the fundamental problem of
> abstracting the mikroBUS connector in DT. Each of these click device chil=
d
> nodes has to be under the parent connector node. Which means a phandle
> to the parent node, which is not generically named. For instance
> if my board has 2 connectors, I would have mikrobus0 and mikrobus1,
> the click board's overlay would look like this:
>
> /dts-v1/;
> /plugin/;
>
> &mikrobus0 {
> 	status =3D "okay";
>
> 	mikrobus_board {
> 		thermo-click {
> 			compatible =3D "maxim,max31855k", "mikrobus-spi";
> 			spi-max-frequency =3D <1000000>;
> 			pinctrl-apply =3D "spi_default";
> 		};
> 	};
> };

If there should only be one DT overlay per click board, how would
you apply that to to different connectors?

> I think this solution is almost there, but once you solve the above
> issue, we could just apply the right overlay for our attached click
> board ahead of time and not need the mikroBUS bus driver at all.

The bus driver would still be needed to do the enumeration of the
children, no? And it could make the chip select translations etc. So
you can use the normal bindings of these devices.

-michael

