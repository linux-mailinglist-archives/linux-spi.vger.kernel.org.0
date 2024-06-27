Return-Path: <linux-spi+bounces-3639-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6991ADD7
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108611C220FA
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947919A28D;
	Thu, 27 Jun 2024 17:19:19 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354621C6A1;
	Thu, 27 Jun 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508759; cv=none; b=I3sFKWSLkiJSXaVE3QC3WzkApuZKPCoDbxbgvJioSq4P93upfqbttBD6ejxQRS5nfVyBNCMNyoGQM4JAUSqHObsySwidhtZg7uOAXyAO4+1ZnbKIHCyTZ+MOs91EgigiV6djlqh0AjnUuqckjILpoiWYchzdgVQZGhzwisxNuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508759; c=relaxed/simple;
	bh=luYSedNdzm4ofXHV31UbQRWYFFZA3S9YbC20XWqdRlM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=YimjSkXBelfirtN+x2FWkXzvy1vEe6+iNscHvbt5RbzgKyHA8b34wAwTZWQ0MOZ4CgqMgiblHD4im5rzE7qT8O4alTBxi19hseqE5H5UHhP8xdfRD0+clOGPG12dyZF9UnIHT1hbNY/aUtSWi6nC5IR8Mcsx9hWhwIxYIEk6wJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id AB10F4CC;
	Thu, 27 Jun 2024 19:12:52 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Jun 2024 19:12:52 +0200
Message-Id: <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
To: "Ayush Singh" <ayush@beagleboard.org>, "Mark Brown"
 <broonie@kernel.org>, "Vaishnav M A" <vaishnav@beagleboard.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Derek Kiernan"
 <derek.kiernan@amd.com>, "Dragan Cvetic" <dragan.cvetic@amd.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Andrew
 Lunn" <andrew@lunn.ch>, <jkridner@beagleboard.org>,
 <robertcnelson@beagleboard.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org> <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>

Hi,

Could you give us a DT snippet of how this should look like with a
board?

On Thu Jun 27, 2024 at 6:26 PM CEST, Ayush Singh wrote:
> +  board:
> +    description: board attached to mikrobus connector
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Shouldn't this be a subnode of the connector?

i.e.

connector {
	compatible =3D "mikrobus-connector";

	// phandles to the parent controllers

	spi {
		temp-sensor@0 {
			compatible =3D "maxim,max31855k";
			reg =3D <0>;
		};
	};

	i2c {
		..
	};
};

I don't think you can introduce a new
  compatible =3D "maxim,max31855k", "mikrobus,spi";
if there is already a binding for "maxim,max31855k". But I might be
wrong. Why is this compatible needed at all?

Also, the mikrobus-connector driver could translate the chipselects.

-michael

