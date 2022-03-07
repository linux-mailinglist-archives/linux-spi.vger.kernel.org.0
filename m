Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9B4D080E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 21:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiCGUA7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 15:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbiCGUA5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 15:00:57 -0500
X-Greylist: delayed 1821 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 12:00:02 PST
Received: from uncle.firstenglishco.com (uncle.firstenglishco.com [194.31.98.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDA6A074
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 12:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=firstenglishco.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=the.sey@firstenglishco.com;
 bh=f9rQClNoJ7BzBL2Qp8GAx0U5VoM=;
 b=pIjGjZYJ4k45C6ylIunh1GxztKJh+FsML58VDiQ/mIL2aOHX5s0B1f/vyVqa2D3yL0982gd4mm8v
   CZIRRbhDawXHyysGCKNeJ5JuDnCo/QWBzNaw1HfwujGZObJIT8OxJq+KiQA5TBcHqHDuxygVExOC
   IbuzyGWCIs4Kibj7NrFivGsxn4A3N2MpXdsS9EkxGoY2cxDww0rZxd657WYI86hIpf5oBjd/5JEk
   iIKxO2jbL9ATwps2p7ra2gd4po4I/iatMpH9JoTk80Nzbpw69vcPgHGxLk9K1T3Lac5+yxBTkacp
   4UMp3aU1IqcBWHpH/StFGILrsxvugWl9deKb4w==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=firstenglishco.com;
 b=h178fhTsmEq6Wn3CyjE5DKLWyU8rVSdx65NwxB1sHbqdgpJjLL6S/b4qlj7Jh98wbc4s3QWshCf5
   5OLb4O+lFpB+l6wQJ0058/v4C79sAC+T8cBkjpuP46giFXX4cSI+aT4hPqKfjNOrYEnk6lSezQ4y
   I/4etjg3MdOEvEBni2sUxGvcfJI2GvGsIyQa70O/i3GA1NnHz7OnKSpurhufDfkezcdSiQHaDKay
   Jqpv7zwxnm24bDoo0RT8RBmvNJQ2mC/s2sfhevUysjpGqHtu+iuI0u9++QzpJodcqEPqZqgP7OMZ
   ok2M/bk6VVmdNJepef/bX+ZeNeGkZSlak5U26A==;
Reply-To: eymencemil404@gmail.com
From:   the.sey@firstenglishco.com
To:     linux-spi@vger.kernel.org
Subject: 073HSBC
Date:   7 Mar 2022 20:29:35 +0100
Message-ID: <20220307202935.3E41C00AC3320390@firstenglishco.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_DBL_MALWARE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_MALWARE Contains a malware URL listed in the Spamhaus
        *       DBL blocklist
        *      [URIs: firstenglishco.com]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8805]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [eymencemil404[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Greetings linux-spi
=20
Good Day. Hope you are well.
=20
I hope my message finds you well and healthy? I am contacting you=20
due to my recent discovery in my bank branch and a profitable=20
proposition for you. I will give you more details regarding my=20
proposal when I get your reply.
Thanks for your understanding.
=20
Best regards
