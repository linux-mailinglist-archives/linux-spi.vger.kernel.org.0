Return-Path: <linux-spi+bounces-4739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B09714F6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90760284AB4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE061B3F08;
	Mon,  9 Sep 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A836Fv+f"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BA1B3B2D;
	Mon,  9 Sep 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876652; cv=none; b=SdyN1SECJMXVf+hnSKLQfeG9UeyOcd/DESJ8ZvktE6gxScYu0MytAlQiwfEdOHc/udizTnjAX5xhAQ1aZIhzZDUyk+uN+ksJQck1arR+Mi4SW0640AKPp6+A1HfYX5ZtUsmnXjAxZV8wargWMX9abUzBTGunIsF9Ualvm42yhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876652; c=relaxed/simple;
	bh=pIhZtWn6SesWpnZgbFbrZv2RDMSRPXToO/0vx8g4BSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmB/jopqjMHTQyfzNB311cvC/lKm7bowKs2PpcSN13N+tAumNwzgYeC1efpAbRBbytOiWMC+4jioLYivZqxfwlMRRK7Z6bWML8KS1RFkVjxs7kywdXLCSDe/xdX+c1+DBmbOfLvEE47fe5kGUHAFJA7GZ3bTlRfsxVQpYYm26qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A836Fv+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A44DC4CEC6;
	Mon,  9 Sep 2024 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876651;
	bh=pIhZtWn6SesWpnZgbFbrZv2RDMSRPXToO/0vx8g4BSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A836Fv+fNIT9wvkmkPwzZwYFxFZoLH7zOkBFCt4mp8VzWqoEB3BViF87CxUCBsUzp
	 792VR8+1KtZbGJ4H2TMoNWufhWaa1u2m5KfjJpfONAYFQ1MbhmnpmEFBw7m/uTUqrI
	 WLCXkbBhyVTnKvewsX2v/S9v6vkrhXvmnwF9HrdBqtED888zjYHL3Izl6qCxclFL/q
	 0NuOGNOWsDqG7jPjTcZrgrlCDQJib7c1coOGpmHkWXcrCidaHm/HQncd492SQgFB47
	 0SBl4M7mh7HLfXmaPEEpgFQuIiw9XctuvKk2M2CEmSEdXlpaJpuo7+msBT5NFR7o0c
	 vE3+MOWaR2hWg==
Date: Mon, 9 Sep 2024 12:10:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: touchscreen: ad7877: add bindings
Message-ID: <agotn5dx7s5oqmpobfayiblt2o36cfp2kg4wfatie4zrybtsw7@ojwf3nqy4mkr>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
 <20240909093101.14113-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909093101.14113-3-antoniu.miclaus@analog.com>

On Mon, Sep 09, 2024 at 12:30:13PM +0300, Antoniu Miclaus wrote:
> Add device tree bindings for the ad7877 driver.

Bindings are for hardware, not driver.

Subject: "add bindings" is quite redundant. Rather say what device you
are adding.

Best regards,
Krzysztof


