Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BB7DAE2
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfHAMHP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 08:07:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfHAMHO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 08:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f3xkY/eMcr3hLJTcCqDn6JIJqtqV2TEQYyha75VNJro=; b=JkztxsOx5SpL3P71geFySO2i5
        PuYvwg9Tn/wa0dHywsm/JipzbzEYbdgi6nIAdswC4qczlDhr5xSKvYEOuto5dmPW3uTvuZsCP6wZg
        hGQh+yFgRpjBzrIw/LUKrNA/w+1aK+fMX9PaxzmNuvcnmi4u25FMFmJPEAv/Fhvrymsq5wx3iazET
        KtFYvbo22XRXV4OarAkdS1CGqttSHOwwyvAfh9sZ8fJZt8zDinUDPe++wKHxNN1S3E/drYBEGj2Jn
        nfB58anDF7WP9Tf2DDy1DweL/CHgALQj17Z/z9wVF0g8rrX8BkSfpHDhdTynnafVsR2XDAwLrxQSJ
        yBD2zogFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht9rS-0006JL-Pz; Thu, 01 Aug 2019 12:07:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 167172029F4C5; Thu,  1 Aug 2019 14:07:09 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:07:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Message-ID: <20190801120709.GC31381@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <20190801112655.GA5488@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801112655.GA5488@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 01, 2019 at 12:26:55PM +0100, Mark Brown wrote:
> On Thu, Aug 01, 2019 at 01:13:53PM +0200, Peter Zijlstra wrote:
> 
> > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> 
> I don't have a cover letter or any other context, what's going on here
> with dependencies?

Patch stands on it own. I just went through the tree looking for FIFO
(ab)users.
