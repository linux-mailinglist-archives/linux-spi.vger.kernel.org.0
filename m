Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A817BD46A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Oct 2023 09:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345408AbjJIHgY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Oct 2023 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjJIHgX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Oct 2023 03:36:23 -0400
Received: from mail.venturelinkbiz.com (mail.venturelinkbiz.com [51.195.119.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B2AB
        for <linux-spi@vger.kernel.org>; Mon,  9 Oct 2023 00:36:19 -0700 (PDT)
Received: by mail.venturelinkbiz.com (Postfix, from userid 1002)
        id D6FD3444C5; Mon,  9 Oct 2023 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelinkbiz.com;
        s=mail; t=1696836976;
        bh=JBV4b8UUo1MSngn/QBoedt1Dv52bT8rWeq4R22MtJMs=;
        h=Date:From:To:Subject:From;
        b=rz9jblSb+lV98s4ns9arF6CRSR2MYrz6sieysXLEmvbEWLfoxeYFnlW33T4sIFKZc
         WpIABXI48a/xET91fG/pu9ie7DL2c6uATn3k6SOiFho3AZ6RFKLIjmkX9jFhBBnD0E
         L2ME0oiGZoqiFJ/B95ZhOF6up+fw4T5B81Vf7cik1ARHyosasgwmWaHSiD/DU/ASBW
         Y9mFueKOL0FSk+UlTll4J7YwnxvYmpYv+BhU3eNo6r4nSiq5CgUAnWFyo2pZ9t1zZk
         UVtlLLLdKuXrAfeBeHHW9tU8FXYMU/QSLQGqgm1glpfOZdDhhgT2wNjjmZeoyIXjNJ
         m4ac/UEafacTQ==
Received: by mail.venturelinkbiz.com for <linux-spi@vger.kernel.org>; Mon,  9 Oct 2023 07:36:06 GMT
Message-ID: <20231009064500-0.1.2v.7yka.0.buh29dnird@venturelinkbiz.com>
Date:   Mon,  9 Oct 2023 07:36:06 GMT
From:   "Michal Rmoutil" <michal.rmoutil@venturelinkbiz.com>
To:     <linux-spi@vger.kernel.org>
Subject: =?UTF-8?Q?Efektivn=C3=AD_sledov=C3=A1n=C3=AD_a_optimalizace_v=C3=BDroby_pro_va=C5=A1i_spole=C4=8Dnost?=
X-Mailer: mail.venturelinkbiz.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,URIBL_DBL_SPAM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dobr=C3=A9 r=C3=A1no,

m=C3=A1te mo=C5=BEnost sledovat stav ka=C5=BEd=C3=A9ho stroje a v=C3=BDro=
bn=C3=ADho procesu z kancel=C3=A1=C5=99e, konferen=C4=8Dn=C3=AD m=C3=ADst=
nosti nebo dokonce z domova =C4=8Di na cest=C3=A1ch =E2=80=93 na va=C5=A1=
em telefonu?

Poskytujeme rychle implementovateln=C3=BD a snadno pou=C5=BEiteln=C3=BD n=
=C3=A1stroj, kter=C3=BD zachyt=C3=AD i n=C4=9Bkolikasekundov=C3=BD mikrop=
rostoj a okam=C5=BEit=C4=9B p=C5=99epo=C4=8D=C3=ADt=C3=A1 vyu=C5=BEit=C3=AD=
 stroje v kontextu dan=C3=A9 v=C3=BDrobn=C3=AD zak=C3=A1zky.

Kdykoli vid=C3=ADte stav objedn=C3=A1vky a jste informov=C3=A1ni o p=C5=99=
=C3=ADpadn=C3=A9m sn=C3=AD=C5=BEen=C3=AD efektivity. Syst=C3=A9m s=C3=A1m=
 analyzuje data a p=C5=99ipravuje cenn=C3=A9 reporty, co=C5=BE oper=C3=A1=
tor=C5=AFm umo=C5=BE=C5=88uje soust=C5=99edit se na v=C3=BDrobn=C3=AD c=C3=
=ADl.

C=C3=ADl je jednoduch=C3=BD: jeden pohled =E2=80=93 cel=C3=A1 tov=C3=A1rn=
a. =C4=8Cek=C3=A1m na odpov=C4=9B=C4=8F, jestli vid=C3=ADte mo=C5=BEnost =
vyu=C5=BEit=C3=AD takov=C3=A9ho n=C3=A1stroje ve va=C5=A1=C3=AD firm=C4=9B=
=2E


Pozdravy
Michal Rmoutil
