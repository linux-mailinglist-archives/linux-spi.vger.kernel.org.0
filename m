Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35172CAA22
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLARub (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 12:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgLARub (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 12:50:31 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0904AC0613D4
        for <linux-spi@vger.kernel.org>; Tue,  1 Dec 2020 09:49:51 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3497B30006262;
        Tue,  1 Dec 2020 18:49:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7E673184F70; Tue,  1 Dec 2020 18:49:08 +0100 (CET)
Date:   Tue, 1 Dec 2020 18:49:08 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe
 error path
Message-ID: <20201201174908.GA5827@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
 <160683107676.35139.5898255579541696458.b4-ty@kernel.org>
 <20201201143027.GA23044@wunner.de>
 <20201201171726.GN5239@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201171726.GN5239@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 01, 2020 at 05:17:26PM +0000, Mark Brown wrote:
> BTW it would be really helpful if you could resend this
> stuff in some more normal fashion (either independently or as a numbered
> thread), it's really breaking my workflow.

Will do, sorry for the inconvenience.

I think I'll base the resent patches on for-5.11, Linus would probably
not be happy to receive such a large quantity of commits this late in the
cycle.  (Shout if you disagree.)

Thanks,

Lukas
