Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309D5188227
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQLY4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 07:24:56 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:39385 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgCQLY4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 07:24:56 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4C603230E1;
        Tue, 17 Mar 2020 12:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584444292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DH7/qC/0vrafdQUdfPhAFCMPVOhjlNydJl9NhPMW6H4=;
        b=lkAth6EIWKqub3WBQbzy1ugASP5btzGanfdrY388qh4nS7e6Ha6bnA1DjlCpYUkUNexJFh
        QOkJGFhWsIx90SMWNSe6WI1wlkC0MhQKQMXpW7dqEqCMRZa5kD8gaDDzDKCxFOjdIARyOs
        kz9z67+kG+gidTJZ/heFu/d98/9qt4w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Mar 2020 12:24:49 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
In-Reply-To: <8c22cb70b7c0acb6769e0c68540ab523@walle.cc>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk>
 <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk>
 <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
 <d05fda0e119405343e540b9768db534f@walle.cc>
 <CA+h21hqt7Xe1LrSDsCVS8zqunQp2tKGhmHDraMirxL595go4nA@mail.gmail.com>
 <8c22cb70b7c0acb6769e0c68540ab523@walle.cc>
Message-ID: <52ce52ed4f045c4276dfb885ed29e835@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 4C603230E1
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.617];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-16 18:15, schrieb Michael Walle:
>>> dd: /dev/mtd0: Input/output error
>> 
>> I don't really have a SPI flash connected to DSPI on any LS1028A 
>> board.
> 
> I'm already debugging it again.

Ok now maybe a more experienced kernel developer could have a look at 
this.

(1) the error is EIO because the actual_length doesn't match the 
expected
     length
(2) I've put trace_printk() where the actual_length is modified:
     in dspi_fifo_write()

         /* Update total number of bytes that were transferred */
         bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
         msg->actual_length += bytes_sent;
         trace_printk("msg=%px actual_length=%d bytes_sent=%d 
word_in_flight=%d oper_word_size=%d\n",
                         msg, msg->actual_length,
                         bytes_sent, dspi->words_in_flight,
                         dspi->oper_word_size);
         dspi->progress += bytes_sent / DIV_ROUND_UP(xfer->bits_per_word, 
8);

    At the start of the foreach transfer loop in 
dspi_transfer_one_message():

         list_for_each_entry(transfer, &message->transfers, 
transfer_list) {
                 trace_printk("%d transfer->length=%d\n", i++, 
transfer->len);
                 dspi->cur_transfer = transfer;

    And at the end of this function:


         }
         trace_printk("returning actual_length=%d\n", 
message->actual_length);

         message->status = status;
         spi_finalize_current_message(ctlr);

         return status;

(3) The trace is attached at the end of this mail. There is a good case 
and the
     bad one. What I've noticed (besides returning the wrong count, eg 
13, which
     seems to be the first one) is the preempt-depth which is always none 
in the
     bad case. In all transfers before, the preempt-depth is 1. The flags 
are
     usually "d.h1", sometimes "d.H1" and in case of the error "d.H.".
     I also don't know why the fifo_write() with actual_length=13 is 
traced after
     all the ones printed inside the interrupt handler. Also something 
seems to
     be off with the words_in_flight and oper_word_size in the bad case.

     So besides the flags.. I still think there is a race between the
     dspi_fifo_write() call in transfer_one_message and the interrupt 
handler
     for the shared data like words_in_flight and oper_word_size.


good one:
               dd-1259  [000] ....  3383.499863: 
dspi_transfer_one_message: 0 transfer->length=1
               dd-1259  [000] ....  3383.499886: dspi_fifo_write: 
msg=ffff800011973840 actual_length=1 bytes_sent=1 word_in_flight=1 
oper_word_size=1
               dd-1259  [000] ....  3383.499891: 
dspi_transfer_one_message: 1 transfer->length=3
               dd-1259  [000] ....  3383.499915: dspi_fifo_write: 
msg=ffff800011973840 actual_length=4 bytes_sent=3 word_in_flight=3 
oper_word_size=1
               dd-1259  [000] ....  3383.499920: 
dspi_transfer_one_message: 2 transfer->length=1
               dd-1259  [000] ....  3383.499940: dspi_fifo_write: 
msg=ffff800011973840 actual_length=5 bytes_sent=1 word_in_flight=1 
oper_word_size=1
               dd-1259  [000] ....  3383.499946: 
dspi_transfer_one_message: 3 transfer->length=64
               dd-1259  [000] d.h1  3383.499973: dspi_fifo_write: 
msg=ffff800011973840 actual_length=21 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.h1  3383.499993: dspi_fifo_write: 
msg=ffff800011973840 actual_length=29 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.h1  3383.500013: dspi_fifo_write: 
msg=ffff800011973840 actual_length=37 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.h1  3383.500032: dspi_fifo_write: 
msg=ffff800011973840 actual_length=45 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.h1  3383.500051: dspi_fifo_write: 
msg=ffff800011973840 actual_length=53 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.h1  3383.500070: dspi_fifo_write: 
msg=ffff800011973840 actual_length=61 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.h1  3383.500089: dspi_fifo_write: 
msg=ffff800011973840 actual_length=69 bytes_sent=8 word_in_flight=4 
oper_word_size=2
               dd-1259  [000] ....  3383.500107: dspi_fifo_write: 
msg=ffff800011973840 actual_length=13 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] ....  3383.500111: 
dspi_transfer_one_message: returning actual_length=69

bad one:
               dd-1259  [000] ....  3383.500149: 
dspi_transfer_one_message: 0 transfer->length=1
               dd-1259  [000] ....  3383.500172: dspi_fifo_write: 
msg=ffff800011973840 actual_length=1 bytes_sent=1 word_in_flight=1 
oper_word_size=1
               dd-1259  [000] ....  3383.500178: 
dspi_transfer_one_message: 1 transfer->length=3
               dd-1259  [000] ....  3383.500202: dspi_fifo_write: 
msg=ffff800011973840 actual_length=4 bytes_sent=3 word_in_flight=3 
oper_word_size=1
               dd-1259  [000] ....  3383.500207: 
dspi_transfer_one_message: 2 transfer->length=1
               dd-1259  [000] ....  3383.500227: dspi_fifo_write: 
msg=ffff800011973840 actual_length=5 bytes_sent=1 word_in_flight=1 
oper_word_size=1
               dd-1259  [000] ....  3383.500232: 
dspi_transfer_one_message: 3 transfer->length=64
               dd-1259  [000] d.H.  3383.500286: dspi_fifo_write: 
msg=ffff800011973840 actual_length=13 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.H.  3383.500307: dspi_fifo_write: 
msg=ffff800011973840 actual_length=21 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.H.  3383.500327: dspi_fifo_write: 
msg=ffff800011973840 actual_length=29 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.H.  3383.500347: dspi_fifo_write: 
msg=ffff800011973840 actual_length=37 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.H.  3383.500366: dspi_fifo_write: 
msg=ffff800011973840 actual_length=45 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.H.  3383.500385: dspi_fifo_write: 
msg=ffff800011973840 actual_length=53 bytes_sent=8 word_in_flight=2 
oper_word_size=4
               dd-1259  [000] d.H.  3383.500404: dspi_fifo_write: 
msg=ffff800011973840 actual_length=61 bytes_sent=8 word_in_flight=4 
oper_word_size=2
               dd-1259  [000] ....  3383.500436: dspi_fifo_write: 
msg=ffff800011973840 actual_length=13 bytes_sent=8 word_in_flight=4 
oper_word_size=2
               dd-1259  [000] ....  3383.500441: 
dspi_transfer_one_message: returning actual_length=13


-michael
