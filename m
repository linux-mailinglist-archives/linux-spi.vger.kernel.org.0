Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6634E153EDD
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 07:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgBFGqx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 01:46:53 -0500
Received: from smtp3.tjgo.jus.br ([45.71.214.101]:53345 "EHLO mx2.tjgo.jus.br"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgBFGqx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 Feb 2020 01:46:53 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 01:46:51 EST
Received: from sv-email-p02.tjgo.jus.br (sv-email-p02.tjgo.jus.br [45.71.214.97])
        by mx2.tjgo.jus.br (Postfix) with ESMTPS id EFF851681D1;
        Thu,  6 Feb 2020 03:37:01 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by sv-email-p02.tjgo.ldc (Postfix) with ESMTP id 5900A6387A;
        Thu,  6 Feb 2020 03:37:00 -0300 (-03)
Received: from sv-email-p02.tjgo.jus.br ([127.0.0.1])
        by localhost (sv-email-p02.tjgo.ldc [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w18jaNpBm2bg; Thu,  6 Feb 2020 03:36:59 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by sv-email-p02.tjgo.ldc (Postfix) with ESMTP id CC16F62397;
        Thu,  6 Feb 2020 03:36:58 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 sv-email-p02.tjgo.ldc CC16F62397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tjgo.jus.br;
        s=DB6EB6C0-19CB-11E9-B608-74AECE7D716B; t=1580971019;
        bh=N7ic5LlI94J/87ZUuJbnr2MyW1XAh52HpvlLWUizZd4=;
        h=Date:From:Message-ID:MIME-Version;
        b=EN/8AGMTZUat81+DU+FgZ6sfc6niakaKcjuwHTEjmosr0cQCGt8ton9MX0EGCGLuM
         7F5FtdFHN1SSZnhsYDJwOjJLYOYyjiK5zcG2zsV31MoyGMKNSGRgYF/GR0sFPuAq01
         0F5ZkOoCsYkTYhhBJwdm2sz/addnBThHUxJrUCoH5hfUCNnLftGO++Jenb5ojO1pws
         +x9Q6VQaepn6i4Jv2+D4zDRL2RF6Sbavl9p8ArTENVkytdVZB8TwGTHfeNqAGTibhQ
         KxaZ0ctkUxHkQk4S9JnIBfrzVRnCY3O4RclJzsZMM3Xkf2T39Tza+IxF0Q3ZcFi4wP
         jlRdHwonFrfiw==
X-Virus-Scanned: amavisd-new at sv-email-p02.tjgo.ldc
Received: from sv-email-p02.tjgo.jus.br ([127.0.0.1])
        by localhost (sv-email-p02.tjgo.ldc [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Sq2MPRiYJqo; Thu,  6 Feb 2020 03:36:58 -0300 (-03)
Received: from sv-email-p00.tjgo.ldc (sv-email-p00.tjgo.ldc [45.71.214.95])
        by sv-email-p02.tjgo.ldc (Postfix) with ESMTP id DF47262322;
        Thu,  6 Feb 2020 03:36:53 -0300 (-03)
Date:   Thu, 6 Feb 2020 03:36:53 -0300 (BRT)
From:   Viviane Jose Pereira <vjpereira@tjgo.jus.br>
Reply-To: Tom Crist <cristtom063@gmail.com>
Message-ID: <1037973316.1008141.1580971013841.JavaMail.zimbra@tjgo.jus.br>
Subject: Re:
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [109.70.100.26]
X-Mailer: Zimbra 8.8.15_GA_3829 (zclient/8.8.15_GA_3829)
Thread-Index: QBmcJ2H7l2hGItrmcrsi+ET2XQTkFA==
Thread-Topic: 
X-HSC-Mail_Inspector-From: vjpereira@tjgo.jus.br
X-HSC-Mail_Inspector-IP: 45.71.214.97
X-HSC-Mail_Inspector-Point: 1
X-HSC-Mail_Inspector-ID: EFF851681D1.AA463
X-HSC-Brasil-HSC_MailInspector: Mensagem OK
X-HSC-Brasil-HSC_MailInspector-SpamCheck: Nao e SPAM,
        HSC MailInspector (cached, Pontuacao=0.268, requerido 6,
        BAYES_00 -3.00, DKIM_VALID_AU -0.10, HELO_NO_DOMAIN 0.00,
        LOTS_OF_MONEY 0.00, MISSING_HEADERS 1.02, RDNS_NONE 0.79,
        REPLYTO_WITHOUT_TO_CC 1.55)
X-HSC-Brasil-HSC_MailInspector-From: vjpereira@tjgo.jus.br
X-Spam-Status: No
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



--=20
Hallo, ich entschuldige mich daf=C3=BCr, dass ich deine Privatsph=C3=A4re g=
est=C3=B6rt habe. Ich kontaktiere Sie f=C3=BCr eine =C3=A4u=C3=9Ferst dring=
ende und vertrauliche Angelegenheit.

Ihnen wurde eine Spende von 15.000.000,00 EUR angeboten Kontakt: cristtom06=
3@gmail.com f=C3=BCr weitere Informationen.

Dies ist keine Spam-Nachricht, sondern eine wichtige Mitteilung an Sie. Ant=
worten Sie auf die obige E-Mail, um immer mehr Informationen =C3=BCber die =
Spende und den Erhalt von Geldern zu erhalten.
