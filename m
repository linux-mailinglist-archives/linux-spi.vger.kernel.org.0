Return-Path: <linux-spi+bounces-9350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0130FB21470
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 20:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423A17B80DF
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983722E4266;
	Mon, 11 Aug 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NRYw99fU"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D132E3B00;
	Mon, 11 Aug 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936570; cv=none; b=GPF+R3gZgjmWp9cZ4qL4QtA0j2cWNpW75tVadkgn+FNyX4c8qbRPKTVIU4GHeELVczFexG9UmtjWbxKx50j4MZtWEnz7ZP8XI9RESzQXz4bmZnllkBvcESWeKKf6YyWnb7AU65L513P95gKucfUC56NQ70t79Jng/q6JrcZgypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936570; c=relaxed/simple;
	bh=1oOevPv2HL7N5y5fnwKsrsnkca5rzzyVIAqak6x0ME4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLqslcIVU3cz7PCh6wFbr34r/xuNXm2TXHcsuNAgEY1d58/27Yxe/75nmO/AWFR8lXNZBuo179nN+KEUemQOKhXcu0X7wriT+Q6SFmFmiYG+nE7QkWGXWZxZ6G0gPclD4wrhfYCvmYm8+Hh1z7MqM+mDLAv/EjsLBmI/hwxSthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NRYw99fU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3wk8/uqaZOZm3CfU5N2jezdVQ9xh++6dLW86ERDiRV4=; b=NRYw99fUM6MHNAik4gY8YsAZwC
	Y1bRAVzqxYSsIBIFti0LkgLNtNGRRznmkxvJTMn+x3hsfYYWuWNJnot58/By43pIDia5cR8ke7c8W
	VP/1X+0lBTlOHaDqXZysLxBaiyhxVtOHpUk9icyrvjeZlTlMSjes6CJXfHFwKNXSfSZQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ulXAO-004MOS-EO; Mon, 11 Aug 2025 20:22:40 +0200
Date: Mon, 11 Aug 2025 20:22:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3 net] microchip: lan865x: Fix LAN8651 autoloading
Message-ID: <a628d8e6-7cb0-4aeb-9c26-0a755c8480f8@lunn.ch>
References: <20250811154858.8207-1-wahrenst@gmx.net>
 <20250811154858.8207-4-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154858.8207-4-wahrenst@gmx.net>

On Mon, Aug 11, 2025 at 05:48:58PM +0200, Stefan Wahren wrote:
> Add SPI ID for LAN8651 devices, which is also defined in the DT bindings.

Maybe this patch should also add to lan865x_dt_ids[] ?

	Andrew

