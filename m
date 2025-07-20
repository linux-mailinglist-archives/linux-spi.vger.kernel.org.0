Return-Path: <linux-spi+bounces-9130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1EB0B326
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 04:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FD817CDB8
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED5174EE4;
	Sun, 20 Jul 2025 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8tEhYXJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91E15CD74;
	Sun, 20 Jul 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752977513; cv=none; b=QJPR5s1bG0ExYCr9+r87h/ERn7kR4jvausv5Vxl3YeGcdSAuGG/teo9LzXwjXIX1E6U+fl7l+hnIgeAsAGdfkiKB6ouE8I8MTqExhMJhROFORbsrAvHMJlUvMo6/06300a+tK9LGRJFte7VI9NntWAihOFSdegI8eSb3eSqgvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752977513; c=relaxed/simple;
	bh=2Vi1uU+0bdsQ/W9FjTj69Nz0jBqNK395nfLAmfvn9X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGT2iAUalzTe3+n6y8zz4sJXfVy6VOebk8i/do9WrZYNt5skyFIzT+0k5WmzE/wScyQg8Ej4HttR+5zcML2+tNQ2mnRy7bZ1xc7sCdxT8iOs1EgXZHBvU/ZpU/upLqVLWUURzGLXTuq6DdUWuodup5wittdL4KkTzpb+zfrFFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8tEhYXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851EDC4CEE3;
	Sun, 20 Jul 2025 02:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752977512;
	bh=2Vi1uU+0bdsQ/W9FjTj69Nz0jBqNK395nfLAmfvn9X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8tEhYXJq4CLqp02HKUhUwEpxI7pFBUqC37mc/wPo63A+6HY7hlRNftOqhEZFpx5u
	 XW7cUoqXCl76PmtjDZQaoWu8xF55oVgTP+Bk/EUOWyuV7yLwhNpqLDSJRUUrvR3ljd
	 k4/Es0rhytK0O9FEPA+P9833hoxh/hcV0HSsBcH7m3UHU2mB72iAR0lUoczKUnJABK
	 TB0ReqIeRx0gNyFWS38tMOtUoKqmO7YQOPacNvyPGdmDTkNqa/biLMv/k3cGMp2tf3
	 pMg6nha3sGCqjEN6WCeyBIBY6gqHObxXjwsUTEZXh5b+Du5Rj9slHGHoyn9bSjs9ed
	 aSk7kIqhMIpWw==
Date: Sat, 19 Jul 2025 21:11:51 -0500
From: Rob Herring <robh@kernel.org>
To: Heiko Schocher <hs@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrei Lalaev <andrey.lalaev@gmail.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: trivial-devices: Document ABB sensors
Message-ID: <20250720021151.GA931647-robh@kernel.org>
References: <20250719063355.73111-1-hs@denx.de>
 <20250719063355.73111-2-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719063355.73111-2-hs@denx.de>

On Sat, Jul 19, 2025 at 08:33:52AM +0200, Heiko Schocher wrote:
> Add documentation for spi based ABB sensors, which are
> currently operated from userspace.

What is userspace? That has nothing to do with bindings.

Please provide some details about this h/w and convince me it is 
trivial.

> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 27930708ccd5..25260c2b81df 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -30,6 +30,8 @@ properties:
>      items:
>        # Entries are sorted alphanumerically by the compatible
>        - enum:
> +            # ABB register based spi sensors
> +          - abb,spi-sensor
>              # Acbel fsg032 power supply
>            - acbel,fsg032
>              # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
> -- 
> 2.20.1
> 

