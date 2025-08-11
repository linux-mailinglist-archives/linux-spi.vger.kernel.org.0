Return-Path: <linux-spi+bounces-9349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAF7B21437
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 20:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB426189C5D7
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E962E0B7C;
	Mon, 11 Aug 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oSj4yrVG"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86E2E0B58;
	Mon, 11 Aug 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936396; cv=none; b=NWzmcSeur3LN7pXWICBXkER6Pc02cBUKNOnYsBGIgw2WrvmtsIH98YD7qQEBEnzGsJtUX15loOPV+2sBJUAykdx0JVBExf8chXEmML1R2FzmRdcmpblNkVsbwJHja3JFeLhwnHpwfPIGzPmPD+ZwquiWumSSZW7PRBND96CFBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936396; c=relaxed/simple;
	bh=OLV8xBf6UeaH+KB6JyBgKgJrCsd+/OaaOELxIUq8tWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtuwqNH4GC683htbkFCdZDeyaYQw74CR/rSuEjD0Ka1G/9BckJY4QttovytlBYRVo5S14GG8InE+YIYR4HZYzxvbLAJeef+TBk1OIF/BecHoauggUczf5gUSHKmi4GposISRIQSmf5EqHv/+IzEMb05JptL7cDZjoi3MG172dGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oSj4yrVG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KFIX0ngHoTYG/qMgOv1yEgYI2hRLy0HvxkOLnE8cDd4=; b=oSj4yrVGEhauTLkXRcrS3NE0EG
	HRRDXwhxFNCHy9nPim1xZ1dv/bJPCiWW8W72tHXgYNHh6abwnlmNZF0E2cQJVBeGumi4QpH/IU8pP
	5CTcHt95JVnVDEexzsW86nEQ0xQ5nykgi8cTwHXByC6OqXHVAcU2ieIuupT/M2iLy4hc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ulX7Z-004MNA-4F; Mon, 11 Aug 2025 20:19:45 +0200
Date: Mon, 11 Aug 2025 20:19:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3 net] microchip: lan865x: fix module autoloading
Message-ID: <ba0a322d-56d7-4714-9869-33c87f478ef5@lunn.ch>
References: <20250811154858.8207-1-wahrenst@gmx.net>
 <20250811154858.8207-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154858.8207-3-wahrenst@gmx.net>

On Mon, Aug 11, 2025 at 05:48:57PM +0200, Stefan Wahren wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from spi_device_id table. While at this, fix
> the misleading variable name (spidev is unrelated to this driver).
> 
> Fixes: 5cd2340cb6a3 ("microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

