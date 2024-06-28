Return-Path: <linux-spi+bounces-3670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75791C31C
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B7F1F22E25
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3F1C6897;
	Fri, 28 Jun 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXGHVV84"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24D1C0DCC;
	Fri, 28 Jun 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590679; cv=none; b=nWr8IFhe/t4+jrlB4EYG4Vi8Pof6dW9wWy7lKk/jIBeIihbdNG0PsVanVjQPNHRn+xWJZVRq34S0hohh6PyBA2zOTO7NLxVyeEsOUVzYJUE8w6WAFMcAjQJxFls+XMhbDVHvmLSGOKyV+a85YpiT1NOA1l3pknm/69GBq/q7PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590679; c=relaxed/simple;
	bh=oTXfR2N6eN/rBWJlM/QQkHwnHvpBAkB6fBJKmFWgmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJGVgwVrTieOhnnU+cZZZCd1jM4bhNPOneJ5keOSae65XwzHd4nvaWG4XFGQlgJjZCxa859GivQmIz3yxImwJrzq02z1cpt6rDgVeJmMVwlR2U3cl7D9DhgLJPtGo2f5GLDIuVIA+12+NU+ug4JBE/EkkpjkhuWxJjmeZn7diWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXGHVV84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D7CC116B1;
	Fri, 28 Jun 2024 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719590679;
	bh=oTXfR2N6eN/rBWJlM/QQkHwnHvpBAkB6fBJKmFWgmyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXGHVV84R2UNCEu9g298LoeAx0ZyOEsBfQK44L0ec56H4f3VQwhojE+81Rnwy+TcM
	 I5AjHgSndtYSBRNJQ6eVyUB8t3tCOT+iVlvVxoszKdjMcfTVVoCQQFdT/0CmcFaJBC
	 CsQcOvngcssNeMhHRU4M7ho7VYtt115QGJR6zUEyNKoc3I0CQBRMNcV/NU1rfbIYPd
	 11LIlC34+YcAO7Lork3rWefTA4utV4aLhP7kgdVDzv6iIqONVJf994omfi67deCeSB
	 RytUpxaEetfcST35QVs9DQNLFl8scGjVrE/JtYVNVspVUrhNn998yVet/oDyZUtPh8
	 Ur9qQgERo7pQA==
Date: Fri, 28 Jun 2024 10:04:36 -0600
From: Rob Herring <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/7] dt-bindings: mikrobus: Add mikrobus board base
Message-ID: <20240628160436.GA3143032-robh@kernel.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-2-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-2-9e6c148bf5f0@beagleboard.org>

On Thu, Jun 27, 2024 at 09:56:12PM +0530, Ayush Singh wrote:
> Base dt bindings for mikrobus addon boards. Contains properties that are
> part of all types of boards (SPI, I2C, etc).
> 
> Each pin in mikroBUS connector can either be used for it's original
> purpose (UART, I2C, SPI, etc) or as a normal GPIO. Introducing
> `pinctrl-apply` allows selecting the pin configuration by name.

This seems pointless. If a board uses UART, then uart_default has to be 
supported. Why does the board need to list it?

> 
> Note: Some mikrobus-connectors might not support all valid pinctrl.
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../devicetree/bindings/mikrobus/mikrobus-board.yaml | 20 ++++++++++++++++++++
>  MAINTAINERS                                          |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml b/Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
> new file mode 100644
> index 000000000000..42e2219c596f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mikrobus/mikrobus-board.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board properties
> +
> +maintainers:
> +  - Ayush Singh <ayush@beagleboard.org>
> +
> +properties:
> +  pinctrl-apply:

Missing a description.

> +    minItems: 1
> +    maxItems: 9
> +    items:
> +      enum: [default, pwm_default, pwm_gpio, uart_default, uart_gpio, i2c_default, i2c_gpio, spi_default,
> +             spi_gpio]
> +
> +additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e4115e93aeb..14eba18832d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15113,6 +15113,7 @@ M:	Ayush Singh <ayush@beagleboard.org>
>  M:	Vaishnav M A <vaishnav@beagleboard.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> +F:	Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
>  
>  MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>  M:	Luka Kovacic <luka.kovacic@sartura.hr>
> 
> -- 
> 2.45.2
> 

