Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E326B8DB3
	for <lists+linux-spi@lfdr.de>; Tue, 14 Mar 2023 09:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCNIoH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Mar 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCNIoG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Mar 2023 04:44:06 -0400
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 01:44:05 PDT
Received: from mail.docworker.pl (mail.docworker.pl [94.177.230.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9815558
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 01:44:05 -0700 (PDT)
Received: by mail.docworker.pl (Postfix, from userid 1002)
        id 610AC82B5F; Tue, 14 Mar 2023 09:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=docworker.pl; s=mail;
        t=1678782971; bh=F9Uuk9o83BVy7SpscM/nJos6FHfnp2pKrNUqPErj3yg=;
        h=Date:From:To:Subject:From;
        b=UIxpAGDKdcpVkUcy1kFnoIygETXN6/Gda6GyD3Ls0tnH+XRLsSZETF8WDGjMXA1tK
         69sRJ3Nx++yAPb9OmM6zLUZUm2/Op1XqnbIOUJU9ABjhBQ06vCvxSiFpWXk+7cEBq1
         873/J65j/9jRVsHAfCyCe7f9NzNpAX7onlorlV6u8t6l1jHNKiNbrdqDFd6gDujIeR
         MR36AAEL2G7EoSWpEaJ6erP3V9MNGMZrScre31mK8lL8gTRsUf2BabjfgoznZQG+C2
         XOPIxbZp7NSuJjlZsFxSTDq9B5usGG/php36BK3UE+M0UZX0+R/m2qb96nmAOpqEvF
         ZZjGQRC+ta2MQ==
Received: by mail.docworker.pl for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 08:35:29 GMT
Message-ID: <20230314084505-0.1.f.xmv.0.kaddkxwnig@docworker.pl>
Date:   Tue, 14 Mar 2023 08:35:29 GMT
From:   =?UTF-8?Q? "Mi=C5=82osz_G=C3=B3recki" ?= 
        <milosz.gorecki@docworker.pl>
To:     <linux-spi@vger.kernel.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.docworker.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: docworker.pl]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: docworker.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.177.230.24 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: docworker.pl]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Szanowni Pa=C5=84stwo,

Od blisko 8 lat skutecznie wspieramy naszych partner=C3=B3w w pozyskiwani=
u klient=C3=B3w. =C5=9Awiadczymy us=C5=82ug=C4=99 generowania lead=C3=B3w=
 z kilkoma unikalnymi cechami jak gwarancja realnego uruchomienia rozm=C3=
=B3w lub wymiana kontaktu. Nadmieni=C4=99 tak=C5=BCe, i=C5=BC kontakty pr=
zekazywane s=C4=85 na wy=C5=82=C4=85czno=C5=9B=C4=87.

Je=C5=9Bli w chwili obecnej poszukujecie Pa=C5=84stwo nowych zapyta=C5=84=
 i lead=C3=B3w sprzeda=C5=BCowych prosz=C4=99 o kontakt lub wskazanie ter=
minu rozmowy.


Pozdrawiam serdecznie
Mi=C5=82osz G=C3=B3recki
