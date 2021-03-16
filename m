Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A162F33DC82
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 19:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhCPSXS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 14:23:18 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55465 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhCPSW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 14:22:58 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6C16022238;
        Tue, 16 Mar 2021 19:22:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615918976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6lxzdYWjc5HQ4RAtVvQYiQ7satUE+Bd1YcmCxWTW9M=;
        b=cGzi/3+3BIIcYMVEgjfjfDvy6Gk5lzjULHA6cEiaoUwz0QPbk6UCslKYwhFI7sZ2CDzku+
        bUkvlIix7mHttd5UxyEZKPWvQUc4eex1XcWpPEVotc44gqY/yTdoKquHnM0W4QLTlE22r0
        bFo71eWQknIVV00g07JrqYeyzce2q/I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Mar 2021 19:22:56 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
In-Reply-To: <20210316180655.6oidvffum7yuwknr@ti.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
 <067c42f3726578ebe60d201a141dfdb6@walle.cc>
 <20210316180655.6oidvffum7yuwknr@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <97410b24785492f9e80999dd7a1ffdea@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-16 19:06, schrieb Pratyush Yadav:
> On 16/03/21 06:45PM, Michael Walle wrote:
>> Am 2021-03-15 19:30, schrieb Pratyush Yadav:
>> 
>> ..
>> > > +patternProperties:
>> > > +  "@[0-9a-f]+":
>> 
>> Shouldn't this be "^.*@[0-9a-f]+$"?
> 
> The pattern has to match _anywhere_ in the string so both should match
> the flash node. Your pattern is more "strict" or "precise". See the 
> note
> at [0].

I know, but specifying the whole line is widely used in the bindings.

-michael
