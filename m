Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3DD186D2A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgCPOe7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 10:34:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:9099 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbgCPOe7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Mar 2020 10:34:59 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gzNK3npSzw;
        Mon, 16 Mar 2020 15:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584369297; bh=hOudjbpJM/i6O6iUKn7YKS/446T6quTRjjEDovUThY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUHvi3hn+IZkxNueKGNO4vNac4PWJjNISwFQ8gDc8X1OQZn1jCb4TsFq6W7wdLDgK
         NMCDROB4hV5KA0wQ5iNR8iixdoSkMj7CVJRVYxZOkSa0I0x1lfi1KyLmzEAxSaQ+Mt
         qwdeu5qEwqoVeONvryRvGubNAVOCbNCFU3/g4B50fVEN0v5CfnA4pbn5pXoJhRFxdj
         M1f69i1+sZb/2nzbbTBltU10hLLQnFwSL4DDPFyN2kFJh/u89lNAhIQ1pVPr/7lc63
         SCqSU80+QZW+tj7HGZH1KAAyY1xlJh26PI6Pd4bMVWEa7bXKvX0eOKl0XGVUyIBFCu
         QLGDX5byW3c8w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 16 Mar 2020 15:34:55 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fix cs_change for last transfer
Message-ID: <20200316143455.GA19141@qmqm.qmqm.pl>
References: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
 <20200316121750.GD5010@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316121750.GD5010@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 16, 2020 at 12:17:50PM +0000, Mark Brown wrote:
> On Sun, Mar 15, 2020 at 06:08:53PM +0100, Micha³ Miros³aw wrote:
> > Generic spi_transfer_one_message() implementation introduced in
> > commit b158935f70b9 has a bug in cs_change handling: it keeps CS
> > asserted when cs_change is set. Fix it.
> 
> >  	struct spi_transfer *xfer;
> > -	bool keep_cs = false;
> > +	bool keep_cs = true;
> >  	int ret = 0;
> >  	struct spi_statistics *statm = &ctlr->statistics;
> >  	struct spi_statistics *stats = &msg->spi->statistics;
> > @@ -1268,7 +1268,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
> >  		if (xfer->cs_change) {
> >  			if (list_is_last(&xfer->transfer_list,
> >  					 &msg->transfers)) {
> > -				keep_cs = true;
> > +				keep_cs = false;
> >  			} else {
> 
> This is the opposite of the intended behaviour - we want to deassert
> chip select at the end of the message unless cs_change is set on the
> last transfer.  If this were broken I would expect to see widespread
> problems being reported.

This is unfortunate naming I suppose. I reread the spi.h comments
a few more times and it seems indeed, that .cs_change == 1 on last
transfer means to a driver: "you may leave CS unchanged" - quite the
reverse compared to non-last transfers.

Please drop this patch then.

Best Regards
Micha³ Miros³aw
